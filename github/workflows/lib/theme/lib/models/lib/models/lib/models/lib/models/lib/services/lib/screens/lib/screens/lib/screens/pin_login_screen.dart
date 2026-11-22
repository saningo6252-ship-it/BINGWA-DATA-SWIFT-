import 'package:flutter/material.dart';
import '../services/app_state_service.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';
import 'registration_screen.dart';

class PinLoginScreen extends StatefulWidget {
  final AppStateService appState;

  const PinLoginScreen({super.key, required this.appState});

  @override
  State<PinLoginScreen> createState() => _PinLoginScreenState();
}

class _PinLoginScreenState extends State<PinLoginScreen> {
  String _pin = '';
  String? _errorText;
  bool _isLoading = false;

  void _onDigitPress(String digit) {
    if (_pin.length >= 4 || _isLoading) return;
    setState(() {
      _pin += digit;
      _errorText = null;
    });
  }

  void _onBackspace() {
    if (_pin.isEmpty || _isLoading) return;
    setState(() {
      _pin = _pin.substring(0, _pin.length - 1);
      _errorText = null;
    });
  }

  Future<void> _onLogin() async {
    if (_pin.length != 4) {
      setState(() {
        _errorText = 'Please enter your 4-digit PIN.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorText = null;
    });

    final ok = await widget.appState.loginWithPin(_pin);
    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    if (!ok) {
      setState(() {
        _errorText = 'Incorrect PIN. Please try again.';
        _pin = '';
      });
      return;
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => HomeScreen(appState: widget.appState),
      ),
    );
  }

  Future<void> _showForgotPinDialog() async {
    final otpController = TextEditingController();
    final newPinController = TextEditingController();

    await showDialog<void>(
      context: context,
      builder: (ctx) {
        String? dialogMsg;
        return StatefulBuilder(
          builder: (ctx, setDialogState) {
            return AlertDialog(
              title: const Text('Forgot PIN Recovery'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Request OTP verification to set a new 4-digit PIN.',
                    style: TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton(
                    onPressed: () async {
                      final phone = widget.appState.currentUser?.phoneNumber ?? '';
                      final res = await widget.appState.requestOtp(phone);
                      setDialogState(() {
                        dialogMsg = res.message;
                      });
                    },
                    child: const Text('Send Recovery OTP'),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'OTP Code'),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: newPinController,
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'New 4-Digit PIN'),
                  ),
                  if (dialogMsg != null) ...[
                    const SizedBox(height: 6),
                    Text(
                      dialogMsg!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.errorRed,
                      ),
                    ),
                  ],
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final err =
                        await widget.appState.resetPin(newPinController.text.trim());
                    if (!ctx.mounted) return;
                    if (err != null) {
                      setDialogState(() => dialogMsg = err);
                    } else {
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('PIN updated. Please log in.')),
                      );
                    }
                  },
                  child: const Text('Save PIN'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildPinDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        final filled = index < _pin.length;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: filled ? AppColors.primaryGreen : AppColors.white,
            border: Border.all(
              color: filled ? AppColors.primaryGreen : AppColors.borderGray,
              width: 2,
            ),
          ),
        );
      }),
    );
  }

  Widget _buildKeyButton(String label, {VoidCallback? onTap, IconData? icon}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        height: 58,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.borderGray),
        ),
        child: icon != null
            ? Icon(icon, color: AppColors.darkText)
            : Text(
                label,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.darkText,
                ),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.appState.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppBusinessInfo.appName),
        actions: [
          TextButton(
            onPressed: () async {
              await widget.appState.logout();
              if (!mounted) return;
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => RegistrationScreen(appState: widget.appState),
                ),
              );
            },
            child: const Text('Logout'),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 8),
              const Text(
                'WELCOME BACK!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppColors.darkGreen,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                user != null
                    ? '${user.fullName} • ${user.phoneNumber}'
                    : 'Enter your PIN',
                style: const TextStyle(color: AppColors.mutedText),
              ),
              const SizedBox(height: 20),
              _buildPinDots(),
              if (_errorText != null) ...[
                const SizedBox(height: 12),
                Text(
                  _errorText!,
                  style: const TextStyle(
                    color: AppColors.errorRed,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
              const Spacer(),
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1.55,
                children: [
                  for (final d in ['1', '2', '3', '4', '5', '6', '7', '8', '9'])
                    _buildKeyButton(d, onTap: () => _onDigitPress(d)),
                  _buildKeyButton('', icon: Icons.backspace_outlined, onTap: _onBackspace),
                  _buildKeyButton('0', onTap: () => _onDigitPress('0')),
                  _buildKeyButton(
                    'CLR',
                    onTap: () => setState(() {
                      _pin = '';
                      _errorText = null;
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _isLoading ? null : _onLogin,
                child: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: AppColors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('Login'),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: _showForgotPinDialog,
                child: const Text('Forgot PIN'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
