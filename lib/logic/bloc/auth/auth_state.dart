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

/// User is authenticated – includes role (admin vs student).
class Authenticated extends AuthState {
  final UserModel user;

  const Authenticated(this.user);

  bool get isAdmin => user.role == UserRole.admin;

  @override
  List<Object?> get props => [user];
}

