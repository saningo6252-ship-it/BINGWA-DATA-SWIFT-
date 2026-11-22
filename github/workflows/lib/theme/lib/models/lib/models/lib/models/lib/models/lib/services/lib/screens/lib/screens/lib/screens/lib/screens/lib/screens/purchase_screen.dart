import 'package:flutter/material.dart';
import '../models/bundle_model.dart';
import '../models/order_model.dart';
import '../services/app_state_service.dart';
import '../theme/app_theme.dart';
import 'order_history_screen.dart';

class PurchaseScreen extends StatefulWidget {
  final AppStateService appState;
  final NetworkType network;
  final BundleOffer offer;

  const PurchaseScreen({
    super.key,
    required this.appState,
    required this.network,
    required this.offer,
  });

  @override
  State<PurchaseScreen> createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  late final TextEditingController _recipientController;
  late final TextEditingController _paymentPhoneController;
  final TextEditingController _customAmountController = TextEditingController();
  final TextEditingController _manualRefController = TextEditingController();

  bool _isSubmitting = false;
  String? _feedbackMessage;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    final defaultPhone = widget.appState.currentUser?.phoneNumber ?? '';
    _recipientController = TextEditingController(text: defaultPhone);
    _paymentPhoneController = TextEditingController(text: defaultPhone);
    if (widget.offer.isCustomAmount && widget.offer.minCustomAmount != null) {
      _customAmountController.text = widget.offer.minCustomAmount.toString();
    }
  }

  @override
  void dispose() {
    _recipientController.dispose();
    _paymentPhoneController.dispose();
    _customAmountController.dispose();
    _manualRefController.dispose();
    super.dispose();
  }

  int? _resolveAmountKes() {
    if (widget.offer.priceKes != null) {
      return widget.offer.priceKes;
    }
    final parsed = int.tryParse(_customAmountController.text.trim());
    if (parsed == null) return null;
    final minVal = widget.offer.minCustomAmount ?? 1;
    final maxVal = widget.offer.maxCustomAmount ?? 499;
    if (parsed < minVal || parsed > maxVal) return null;
    return parsed;
  }

  OrderModel _buildDraftOrder({
    required String recipientPhone,
    required String paymentPhone,
    required int amountKes,
  }) {
    final orderId = 'ORD_${DateTime.now().millisecondsSinceEpoch}';
    return OrderModel(
      orderId: orderId,
      network: widget.network,
      itemName: widget.offer.name,
      recipientPhone: recipientPhone,
      paymentPhone: paymentPhone,
      amountKes: amountKes,
      createdAt: DateTime.now(),
      paymentStatus: 'Pending Payment',
      deliveryStatus: OrderLifecycleStatus.pendingPayment,
    );
  }

  Future<void> _onConfirmAndPay() async {
    if (!widget.appState.isStoreOpen) {
      setState(() {
        _isError = true;
        _feedbackMessage =
            'Store is currently closed and not accepting new orders.';
      });
      return;
    }

    final recipient =
        AppStateService.normalizeKenyanPhone(_recipientController.text);
    final payer =
        AppStateService.normalizeKenyanPhone(_paymentPhoneController.text);
    final amount = _resolveAmountKes();

    if (recipient == null) {
      setState(() {
        _isError = true;
        _feedbackMessage =
            'Enter a valid Recipient Phone Number (e.g. 07XXXXXXXX or 01XXXXXXXX).';
      });
      return;
    }
    if (payer == null) {
      setState(() {
        _isError = true;
        _feedbackMessage =
            'Enter a valid M-PESA Payment Phone Number (e.g. 07XXXXXXXX or 01XXXXXXXX).';
      });
      return;
    }
    if (amount == null) {
      final minVal = widget.offer.minCustomAmount ?? 1;
      final maxVal = widget.offer.maxCustomAmount ?? 499;
      setState(() {
        _isError = true;
        _feedbackMessage =
            'Enter a valid amount between KES $minVal and KES $maxVal.';
      });
      return;
    }

    setState(() {
      _isSubmitting = true;
      _feedbackMessage = null;
      _isError = false;
    });

    final order = _buildDraftOrder(
      recipientPhone: recipient,
      paymentPhone: payer,
      amountKes: amount,
    );

    final stkResult = await widget.appState.initiateStkPush(
      orderId: order.orderId,
      paymentPhone: payer,
      amountKes: amount,
    );

    if (!mounted) return;

    setState(() {
      _isSubmitting = false;
      _isError = !stkResult.initiated;
      _feedbackMessage = stkResult.message;
    });
  }

  void _onManualPaidSubmitted() {
    if (!widget.appState.isStoreOpen) {
      setState(() {
        _isError = true;
        _feedbackMessage =
            'Store is currently closed and not accepting new orders.';
      });
      return;
    }

    final recipient =
        AppStateService.normalizeKenyanPhone(_recipientController.text);
    final payer =
        AppStateService.normalizeKenyanPhone(_paymentPhoneController.text);
    final amount = _resolveAmountKes();
    final ref = _manualRefController.text.trim();

    if (recipient == null || payer == null || amount == null) {
      setState(() {
        _isError = true;
        _feedbackMessage =
            'Check recipient phone, payment phone, and amount before submitting manual payment.';
      });
      return;
    }
    if (ref.length < 6) {
      setState(() {
        _isError = true;
        _feedbackMessage =
            'Enter your M-PESA transaction reference code (e.g. from Till ${AppBusinessInfo.tillNumber}).';
      });
      return;
    }

    final order = _buildDraftOrder(
      recipientPhone: recipient,
      paymentPhone: payer,
      amountKes: amount,
    );

    widget.appState.recordManualTillSubmission(
      order: order,
      mpesaReference: ref,
    );

    setState(() {
      _isError = false;
      _feedbackMessage =
          'Submitted reference $ref for verification against Till ${AppBusinessInfo.tillNumber}. Payment is not marked successful until verified.';
    });
  }

  @override
  Widget build(BuildContext context) {
    final resolvedAmount = _resolveAmountKes();

    return Scaffold(
      appBar: AppBar(
        title: const Text('CONFIRM YOUR PURCHASE'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'Order History',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => OrderHistoryScreen(appState: widget.appState),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (!widget.appState.isStoreOpen) ...[
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
              ],
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: const BorderSide(color: AppColors.borderGray),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Network: ${widget.network.displayName}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Bundle: ${widget.offer.name}',
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Validity: ${widget.offer.validity}',
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.mutedText,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        resolvedAmount != null
                            ? 'Amount: KES $resolvedAmount'
                            : 'Amount: ${widget.offer.priceDisplay}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primaryGreen,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (widget.offer.isCustomAmount) ...[
                const SizedBox(height: 14),
                TextField(
                  controller: _customAmountController,
                  keyboardType: TextInputType.number,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    labelText:
                        'Enter Amount (KES ${widget.offer.minCustomAmount ?? 1}–${widget.offer.maxCustomAmount ?? 499})',
                    prefixIcon: const Icon(Icons.payments_outlined),
                  ),
                ),
              ],
              const SizedBox(height: 14),
              TextField(
                controller: _recipientController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Recipient Phone Number',
                  hintText: 'Can be another phone number',
                  prefixIcon: Icon(Icons.phone_forwarded_outlined),
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: _paymentPhoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Payment Phone Number (M-PESA)',
                  prefixIcon: Icon(Icons.phone_android),
                ),
              ),
              const SizedBox(height: 18),
              ElevatedButton(
                onPressed:
                    (_isSubmitting || !widget.appState.isStoreOpen)
                        ? null
                        : _onConfirmAndPay,
                child: _isSubmitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: AppColors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('CONFIRM & PAY'),
              ),
              if (_feedbackMessage != null) ...[
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
                    _feedbackMessage!,
                    style: TextStyle(
                      color:
                          _isError ? AppColors.errorRed : AppColors.darkGreen,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 24),
              Card(
                color: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: const BorderSide(color: AppColors.borderGray),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'HOW TO BUY MANUALLY',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: AppColors.darkGreen,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text('1. Open M-PESA.'),
                      const Text('2. Select Lipa na M-PESA.'),
                      const Text('3. Select Buy Goods.'),
                      const Text(
                        '4. Enter Till Number: ${AppBusinessInfo.tillNumber}.',
                      ),
                      Text(
                        '5. Enter Amount${resolvedAmount != null ? ': KES $resolvedAmount' : ''}.',
                      ),
                      const Text('6. Enter M-PESA PIN.'),
                      const Divider(height: 20),
                      const Text(
                        'Business: ${AppBusinessInfo.businessName}\n'
                        'Till: ${AppBusinessInfo.tillNumber}\n'
                        'Support: ${AppBusinessInfo.supportPhone}',
                        style: TextStyle(fontSize: 13, height: 1.4),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _manualRefController,
                        textCapitalization: TextCapitalization.characters,
                        decoration: const InputDecoration(
                          labelText: 'M-PESA Transaction Code',
                          hintText: 'e.g. TKL1234567',
                        ),
                      ),
                      const SizedBox(height: 12),
                      OutlinedButton(
                        onPressed: widget.appState.isStoreOpen
                            ? _onManualPaidSubmitted
                            : null,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primaryGreen,
                          side: const BorderSide(color: AppColors.primaryGreen),
                          minimumSize: const Size.fromHeight(44),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('I HAVE PAID'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
