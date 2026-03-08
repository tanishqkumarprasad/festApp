import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CoordinatorModel extends Equatable {
  final String id;
  final String name;
  final String club;
  final String contact;
  final String email;

  const CoordinatorModel({
    required this.id,
    required this.name,
    required this.club,
    required this.contact,
    required this.email,
  });

  factory CoordinatorModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? <String, dynamic>{};
    return CoordinatorModel(
      id: doc.id,
      name: (data['name'] as String?)?.trim() ?? '',
      club: (data['club'] as String?)?.trim() ?? '',
      contact: (data['contact'] as String?)?.trim() ?? '',
      email: (data['email'] as String?)?.trim() ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'club': club,
      'contact': contact,
      'email': email,
    };
  }

  @override
  List<Object?> get props => [id, name, club, contact, email];
}