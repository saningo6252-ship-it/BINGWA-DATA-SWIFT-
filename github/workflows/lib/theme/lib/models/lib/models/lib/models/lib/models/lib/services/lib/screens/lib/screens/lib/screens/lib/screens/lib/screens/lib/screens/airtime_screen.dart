import 'package:flutter/material.dart';
import '../models/bundle_model.dart';
import '../services/app_state_service.dart';
import '../theme/app_theme.dart';

class AirtimeScreen extends StatefulWidget {
  final AppStateService appState;
  final NetworkType initialNetwork;

  const AirtimeScreen({
    super.key,
    required this.appState,
    this.initialNetwork = NetworkType.safaricom,
  });

  @override
  State<AirtimeScreen> createState() => _AirtimeScreenState();
}

class _AirtimeScreenState extends State<AirtimeScreen> {
  late NetworkType _selectedNetwork;
  late final TextEditingController _phoneController;
  final TextEditingController _amountController = TextEditingController();

  bool _isSubmitting = false;
  String? _statusMessage;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    _selectedNetwork = widget.initialNetwork;
    _phoneController = TextEditingController(
      text: widget.appState.currentUser?.phoneNumber ?? '',
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _onBuyAirtime() async {
    if (!widget.appState.isStoreOpen) {
      setState(() {
        _isError = true;
        _statusMessage =
            'Store is temporarily not accepting new orders.';
      });
      return;
    }

    final phone =
        AppStateService.normalizeKenyanPhone(_phoneController.text);
    final amount = int.tryParse(_amountController.text.trim());

    if (phone == null) {
      setState(() {
        _isError = true;
        _statusMessage =
            'Enter a valid Kenyan phone number (e.g. 07XXXXXXXX or 01XXXXXXXX).';
      });
      return;
    }

    if (amount == null || amount < 5 || amount > 10000) {
      setState(() {
        _isError = true;
        _statusMessage =
            'Airtime amount must be between KES 5 and KES 10,000.';
      });
      return;
    }

    setState(() {
      _isSubmitting = true;
      _statusMessage = null;
      _isError = false;
    });

    final orderId = 'AIR_${DateTime.now().millisecondsSinceEpoch}';
    final stk = await widget.appState.initiateStkPush(
      orderId: orderId,
      paymentPhone: phone,
      amountKes: amount,
    );

    if (!mounted) return;

    setState(() {
      _isSubmitting = false;
      _isError = !stk.initiated;
      _statusMessage = stk.initiated
          ? 'STK Push sent for KES $amount ${_selectedNetwork.displayName} airtime ($phone). Complete M-PESA PIN to confirm payment.'
          : stk.message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AIRTIME TOP-UP'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (!widget.appState.isStoreOpen)
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF3C7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Store is temporarily not accepting new orders.',
                    style: TextStyle(
                      color: AppColors.warningAmber,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              const Text(
                'Select Network',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.darkText,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<NetworkType>(
                value: _selectedNetwork,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.cell_tower),
                ),
                items: NetworkType.values
                    .map(
                      (net) => DropdownMenuItem(
                        value: net,
                        child: Text(net.displayName),
                      ),
                    )
                    .toList(),
                onChanged: (val) {
                  if (val != null) {
                    setState(() => _selectedNetwork = val);
                  }
                },
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Enter Phone Number',
                  prefixIcon: Icon(Icons.phone_android),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Enter Amount (KES 5 – KES 10,000)',
                  prefixIcon: Icon(Icons.payments_outlined),
                ),
              ),
              const SizedBox(height: 22),
              ElevatedButton(
                onPressed: (_isSubmitting || !widget.appState.isStoreOpen)
                    ? null
                    : _onBuyAirtime,
                child: _isSubmitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: AppColors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('BUY AIRTIME'),
              ),
              if (_statusMessage != null) ...[
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _isError
                        ? const Color(0xFFFEE2E2)
                        : AppColors.lightGreen,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    _statusMessage!,
                    style: TextStyle(
                      color:
                          _isError ? AppColors.errorRed : AppColors.darkGreen,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
