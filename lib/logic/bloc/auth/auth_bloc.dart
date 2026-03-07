import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/auth_error_messages.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({AuthRepository? authRepository})
      : _authRepository = authRepository ?? AuthRepository(),
        super(const AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LoginRequested>(_onLoginRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<LoggedIn>(_onLoggedIn);
    on<LoggedOut>(_onLoggedOut);
  }

  Future<void> _onAppStarted(
    AppStarted event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    await emit.forEach<UserModel?>(
      _authRepository.userStream,
      onData: (UserModel? user) {
        if (user == null) {
          return const Unauthenticated();
        }
        return Authenticated(user);
      },
      onError: (_, __) => const Unauthenticated(),
    );
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      await _authRepository.signIn(
        email: event.email,
        password: event.password,
      );
      // Success: auth state stream will emit and update authentication state.
    } catch (e, _) {
      emit(AuthError(authErrorMessage(e)));
    }
  }

  Future<void> _onSignUpRequested(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      await _authRepository.signUp(
        email: event.email,
        password: event.password,
        displayName: event.displayName,
        rollNo: event.rollNo,
      );
      // Successful signup – user document created and signed out.
      emit(const SignupSuccess());
    } catch (e, _) {
      final message = e is ArgumentError
          ? e.message
          : authErrorMessage(e);
      emit(AuthError(message));
    }
  }

  Future<void> _onLoggedIn(
    LoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    final user = event.user;
    if (user is UserModel) {
      emit(Authenticated(user));
    } else {
      emit(const Unauthenticated());
    }
  }

  Future<void> _onLoggedOut(
    LoggedOut event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    await _authRepository.signOut();
    emit(const Unauthenticated());
  }
}

