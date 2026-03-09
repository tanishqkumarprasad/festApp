import 'package:equatable/equatable.dart';

class Coordinator extends Equatable {
  final String name;
  final String role; // 'Coordinator' or 'Co-coordinator'

  const Coordinator({required this.name, required this.role});

  @override
  List<Object?> get props => [name, role];
}

class UpcomingEventModel extends Equatable {
  final String eventName;
  final String campus; // 'Patna' or 'Bihta'
  final DateTime eventDate;
  final String registrationLink;
  final List<Coordinator> coordinators;

  const UpcomingEventModel({
    required this.eventName,
    required this.campus,
    required this.eventDate,
    required this.registrationLink,
    required this.coordinators,
  });

  @override
  List<Object?> get props => [
    eventName,
    campus,
    eventDate,
    registrationLink,
    coordinators,
  ];
}
