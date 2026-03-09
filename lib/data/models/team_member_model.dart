import 'package:equatable/equatable.dart';

class TeamMember extends Equatable {
  final String team;
  final String role; // 'Coordinator' or 'Co-coordinator'
  final String name;
  final String? email;
  final String? phone;

  const TeamMember({
    required this.team,
    required this.role,
    required this.name,
    this.email,
    this.phone,
  });

  @override
  List<Object?> get props => [team, role, name, email, phone];
}
