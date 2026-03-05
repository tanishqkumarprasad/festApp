import 'package:equatable/equatable.dart';

enum UserRole { admin, student }

class UserModel extends Equatable {
  final String uid;
  final String? email;
  final String? displayName;
  final UserRole role;

  const UserModel({
    required this.uid,
    required this.role,
    this.email,
    this.displayName,
  });

  static UserRole roleFromString(String? raw) {
    final v = (raw ?? '').trim().toLowerCase();
    if (v == 'admin') return UserRole.admin;
    return UserRole.student;
  }

  static String roleToString(UserRole role) {
    return role == UserRole.admin ? 'admin' : 'student';
  }

  factory UserModel.fromMap(String uid, Map<String, dynamic> map) {
    return UserModel(
      uid: uid,
      email: (map['email'] as String?)?.trim(),
      displayName: (map['displayName'] as String?)?.trim(),
      role: roleFromString(map['role'] as String?),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'displayName': displayName,
      'role': roleToString(role),
    };
  }

  @override
  List<Object?> get props => [uid, email, displayName, role];
}

