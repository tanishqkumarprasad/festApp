import 'package:equatable/equatable.dart';

enum UserRole { admin, student }

class UserModel extends Equatable {
  final String uid;
  final String? email;
  final String? displayName;
  final String? rollNo; // Added rollNo field
  final UserRole role;

  const UserModel({
    required this.uid,
    required this.role,
    this.email,
    this.displayName,
    this.rollNo,
  });

  static UserRole roleFromString(String? raw) {
    final v = (raw ?? '').trim().toLowerCase();
    if (v == 'admin') return UserRole.admin;
    return UserRole.student; // 'user' (spec) or legacy 'student' in Firestore
  }

  /// Firestore stores "user" (student) or "admin" per spec.
  static String roleToString(UserRole role) {
    return role == UserRole.admin ? 'admin' : 'user';
  }

  factory UserModel.fromMap(String uid, Map<String, dynamic> map) {
    return UserModel(
      uid: uid,
      email: (map['email'] as String?)?.trim(),
      displayName: (map['displayName'] as String?)?.trim(),
      rollNo: (map['rollNo'] as String?)?.trim(), // Mapping rollNo
      role: roleFromString(map['role'] as String?),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'displayName': displayName,
      'rollNo': rollNo, // Adding rollNo to Map
      'role': roleToString(role),
    };
  }

  @override
  // Added rollNo to props for value equality
  List<Object?> get props => [uid, email, displayName, rollNo, role];
}