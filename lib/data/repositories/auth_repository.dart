import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

import '../../core/utils/email_validator.dart';
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

      // Fetch additional profile data (including role and rollNo) from Firestore
      final doc = await _firestoreProvider.userDoc(fbUser.uid).get();
      final data = doc.data() ?? <String, dynamic>{};

      // Merge Firebase Auth data if Firestore is missing it
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
      email: email.trim(),
      password: password,
    );
    final fb.User user = cred.user!;

    // Fetch user data from Firestore to get the rollNo and role
    final doc = await _firestoreProvider.userDoc(user.uid).get();
    final data = doc.data() ?? <String, dynamic>{
      'email': user.email,
      'displayName': user.displayName,
      'role': UserModel.roleToString(UserRole.student),
      'rollNo': null, // Default if not found
    };

    return UserModel.fromMap(user.uid, data);
  }

  Future<UserModel> signUp({
    required String email,
    required String password,
    String? displayName,
    String? rollNo,
  }) async {
    // Restrict registration to student accounts only using @nitp.ac.in.
    if (!isNitpEmail(email)) {
      throw ArgumentError(
        'Only NIT Patna email addresses are allowed for student accounts.',
      );
    }

    final cred = await _authProvider.signUpWithEmailPassword(
      email: email.trim(),
      password: password,
    );
    final fb.User user = cred.user!;

    final userModel = UserModel(
      uid: user.uid,
      email: user.email,
      displayName: displayName ?? user.displayName,
      rollNo: rollNo,
      role: UserRole.student,
    );

    // Firestore: users/{uid} with email, role, createdAt, isActive per spec.
    final Map<String, dynamic> docData = <String, dynamic>{
      'email': user.email ?? email.trim(),
      'role': UserModel.roleToString(UserRole.student),
      'createdAt': FieldValue.serverTimestamp(),
      'isActive': true,
    };
    if ((displayName ?? '').trim().isNotEmpty) {
      docData['displayName'] = displayName!.trim();
    }
    if ((rollNo ?? '').trim().isNotEmpty) {
      docData['rollNo'] = rollNo!.trim();
    }
    await _firestoreProvider.userDoc(user.uid).set(docData);

    // Immediately sign the user out after successful registration.
    await _authProvider.signOut();

    return userModel;
  }

  Future<void> signOut() => _authProvider.signOut();
}
