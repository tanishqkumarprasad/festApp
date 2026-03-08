import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/bloc/auth/auth_bloc.dart';
import '../../../logic/bloc/auth/auth_state.dart';
import '../../router/app_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // Reduced delay to 2 seconds for a snappier feel
        Future.delayed(const Duration(seconds: 2), () {
          if (context.mounted) {
            if (state is Authenticated) {
              AppRouter.navigateToHome(context, state.user.role.name);
            } else {
              AppRouter.navigateToRoleSelection(context);
            }
          }
        });
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Explicitly targeting the root assets folder
              // Change this in lib/presentation/screens/splash/splash_screen.dart
              Image.asset(
                'assets/festLogo.png',
                color: Colors.black,
                width: 250,
                height: 250,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Text(
                    "IMAGE NOT FOUND",
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  );
                },
              ),
              const SizedBox(height: 30),
              const Text(
                "TATVA 2026",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE53935), // The red from your logo
                  letterSpacing: 2.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
