import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/user_model.dart';
import '../../logic/bloc/auth/auth_bloc.dart';
import '../../logic/bloc/auth/auth_state.dart';
import 'app_router.dart';

/// Wraps a route that requires authentication.
/// Redirects to role selection if unauthenticated; enforces role for admin/user routes.
class AuthGuard extends StatelessWidget {
  const AuthGuard({
    super.key,
    required this.child,
    this.requiredRole,
  });

  final Widget child;
  /// 'admin' or 'student' (user). If null, any authenticated role is allowed.
  final String? requiredRole;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is! Authenticated) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRouter.roleSelection,
                (route) => false,
              );
            }
          });
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final user = state.user;
        final roleStr = user.role == UserRole.admin ? 'admin' : 'student';
        if (requiredRole != null && requiredRole != roleStr) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRouter.roleSelection,
                (route) => false,
              );
            }
          });
          return const Scaffold(
            body: Center(child: Text('Access denied')),
          );
        }

        return child;
      },
    );
  }
}
