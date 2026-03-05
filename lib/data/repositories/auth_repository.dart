import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as fb;

import '../dataproviders/firebase_auth_provider.dart';
import '../dataproviders/firestore_provider.dart';
import '../models/user_model.dart';

class AuthRepository {
  final FirebaseAuthProvider _authProvider;
  final FirestoreProvider _firestoreProvider;

  AuthRepository({
    FirebaseAuthProvider? authProvider,
    FirestoreProvider? firestoreProvider,
  })  : _authProvider = authProvider ?? FirebaseAuthProvider(),
        _firestoreProvider = firestoreProvider ?? FirestoreProvider();

  Stream<UserModel?> get userStream async* {
    await for (final fb.User? fbUser
        in _authProvider.authStateChanges()) {
      if (fbUser == null) {
        yield null;
        continue;
      }

      // Fetch additional profile data (including role) from Firestore
      final doc = await _firestoreProvider.userDoc(fbUser.uid).get();
      final data = doc.data() ?? <String, dynamic>{};
      data['email'] ??= fbUser.email;
      data['displayName'] ??= fbUser.displayName;

      yield UserModel.fromMap(fbUser.uid, data);
    }
  }

  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    final cred = await _authProvider.signInWithEmailPassword(
      email: email,
      password: password,
    );
    final fb.User user = cred.user!;
    final doc = await _firestoreProvider.userDoc(user.uid).get();
    final data = doc.data() ?? <String, dynamic>{
      'email': user.email,
      'displayName': user.displayName,
      'role': UserModel.roleToString(UserRole.student),
    };
    return UserModel.fromMap(user.uid, data);
  }

  Future<UserModel> signUp({
    required String email,
    required String password,
    UserRole role = UserRole.student,
  }) async {
    final cred = await _authProvider.signUpWithEmailPassword(
      email: email,
      password: password,
    );
    final fb.User user = cred.user!;
    final userModel = UserModel(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      role: role,
    );
    await _firestoreProvider.userDoc(user.uid).set(userModel.toMap());
    return userModel;
  }

  Future<void> signOut() => _authProvider.signOut();
}

