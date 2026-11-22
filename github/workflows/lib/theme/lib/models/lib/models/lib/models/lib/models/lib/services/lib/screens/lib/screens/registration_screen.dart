import 'package:flutter/material.dart';
import '../services/app_state_service.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';
import 'pin_login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  final AppStateService appState;

  const RegistrationScreen({super.key, required this.appState});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  final _pinController = TextEditingController();
  final _referralController = TextEditingController();

  bool _isSendingOtp = false;
  bool _isRegistering = false;
  String? _statusMessage;
  bool _isError = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _otpController.dispose();
    _pinController.dispose();
    _referralController.dispose();
    super.dispose();
  }

  Future<void> _onSendOtp() async {
    setState(() {
      _isSendingOtp = true;
      _statusMessage = null;
      _isError = false;
    });

    final result = await widget.appState.requestOtp(_phoneController.text);
    if (!mounted) return;

    setState(() {
      _isSendingOtp = false;
      _statusMessage = result.message;
      _isError = !result.sent;
    });
  }

  Future<void> _onRegister() async {
    if (_nameController.text.trim().isEmpty) {
      setState(() {
        _statusMessage = 'Please enter your full name.';
        _isError = true;
      });
      return;
    }

    setState(() {
      _isRegistering = true;
      _statusMessage = null;
      _isError = false;
    });

    final error = await widget.appState.registerCustomer(
      fullName: _nameController.text,
      phoneNumber: _phoneController.text,
      pin: _pinController.text.trim(),
      referredByCode: _referralController.text,
    );

    if (!mounted) return;

    setState(() {
      _isRegistering = false;
    });

    if (error != null) {
      setState(() {
        _statusMessage = error;
        _isError = true;
      });
      return;
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => HomeScreen(appState: widget.appState),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Registration'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.lightGreen,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppBusinessInfo.appName,
                      style: TextStyle(
                        color: AppColors.darkGreen,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      AppBusinessInfo.tagline,
                      style: TextStyle(color: AppColors.darkText, fontSize: 13),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _nameController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number (e.g. 07XXXXXXXX)',
                  prefixIcon: Icon(Icons.phone_android),
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: _isSendingOtp ? null : _onSendOtp,
                icon: _isSendingOtp
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.sms_outlined),
                label: const Text('Send OTP'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primaryGreen,
                  side: const BorderSide(color: AppColors.primaryGreen),
                  minimumSize: const Size.fromHeight(46),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Verification Code (OTP)',
                  prefixIcon: Icon(Icons.verified_user_outlined),
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: _pinController,
                keyboardType: TextInputType.number,
                maxLength: 4,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Create 4-Digit PIN',
                  prefixIcon: Icon(Icons.lock_outline),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _referralController,
                textCapitalization: TextCapitalization.characters,
                decoration: const InputDecoration(
                  labelText: 'Referral Code (Optional)',
                  prefixIcon: Icon(Icons.card_giftcard_outlined),
                ),
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
                      color: _isError
                          ? AppColors.errorRed
                          : AppColors.darkGreen,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isRegistering ? null : _onRegister,
                child: _isRegistering
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: AppColors.white,
                          strokeWidth: 2.2,
                        ),
                      )
                    : const Text('Complete Registration'),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => PinLoginScreen(appState: widget.appState),
                    ),
                  );
                },
                child: const Text('Already registered? Login with PIN'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
