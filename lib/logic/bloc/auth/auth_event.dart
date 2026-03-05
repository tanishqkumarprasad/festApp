import 'package:equatable/equatable.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Fired when the app starts (e.g. Splash) to determine
/// whether a user session already exists.
class AppStarted extends AuthEvent {
  const AppStarted();
}

/// Fired when a user successfully logs in or signs up via UI.
/// Carries the newly authenticated user.
class LoggedIn extends AuthEvent {
  final Object user;

  const LoggedIn(this.user);

  @override
  List<Object?> get props => [user];
}

/// Fired when the user taps "Logout".
class LoggedOut extends AuthEvent {
  const LoggedOut();
}

