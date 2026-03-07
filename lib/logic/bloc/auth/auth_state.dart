import 'package:equatable/equatable.dart';

import '../../../data/models/user_model.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Initial state while determining if a session exists.
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// While talking to Firebase (login/logout, session check).
class AuthLoading extends AuthState {
  const AuthLoading();
}

/// User is not authenticated – show login / signup.
class Unauthenticated extends AuthState {
  const Unauthenticated();
}

/// Signup completed successfully – user has been created and signed out.
class SignupSuccess extends AuthState {
  const SignupSuccess();
}

/// Auth operation failed – show readable error (e.g. wrong password).
class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

/// User is authenticated – includes role (admin vs student).
class Authenticated extends AuthState {
  final UserModel user;

  const Authenticated(this.user);

  bool get isAdmin => user.role == UserRole.admin;

  @override
  List<Object?> get props => [user];
}

