import 'package:equatable/equatable.dart';

class UpcomingEventModel extends Equatable {
  final String eventName;
  final String campus; // 'Patna' or 'Bihta'
  final DateTime eventDate;
  final String registrationLink;

  const UpcomingEventModel({
    required this.eventName,
    required this.campus,
    required this.eventDate,
    required this.registrationLink,
  });

  @override
  List<Object?> get props => [eventName, campus, eventDate, registrationLink];
}
