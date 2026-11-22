import 'dart:async';
import 'package:flutter/material.dart';
import '../services/app_state_service.dart';
import '../theme/app_theme.dart';
import 'pin_login_screen.dart';
import 'registration_screen.dart';

class SplashScreen extends StatefulWidget {
  final AppStateService appState;

  const SplashScreen({super.key, required this.appState});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _boot();
  }

  Future<void> _boot() async {
    await widget.appState.initializeSession();
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    final Widget nextScreen = widget.appState.currentUser != null
        ? PinLoginScreen(appState: widget.appState)
        : RegistrationScreen(appState: widget.appState);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => nextScreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.darkGreen, AppColors.primaryGreen],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(
                    Icons.shopping_bag_rounded,
                    size: 52,
                    color: AppColors.primaryGreen,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  AppBusinessInfo.appName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.6,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  AppBusinessInfo.tagline,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.lightGreen,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 36),
                const CircularProgressIndicator(
                  color: AppColors.white,
                  strokeWidth: 2.6,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
