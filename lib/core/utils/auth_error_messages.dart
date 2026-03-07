import 'package:firebase_auth/firebase_auth.dart' as fb;

/// Maps Firebase Auth and custom auth errors to user-friendly messages.
String authErrorMessage(Object error, {String? fallback}) {
  if (error is fb.FirebaseAuthException) {
    switch (error.code) {
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'weak-password':
        return 'Password is too weak. Use at least 6 characters.';
      case 'email-already-in-use':
        return 'Account already exists. Please login.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'user-not-found':
        return 'No account found with this email.';
      case 'invalid-credential':
        return 'Invalid email or password.';
      case 'invalid-login-credentials':
        return 'Invalid email or password.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'operation-not-allowed':
        return 'Email/password sign-in is not enabled.';
      default:
        return error.message ?? fallback ?? 'Something went wrong. Please try again.';
    }
  }
  return fallback ?? error.toString();
}
