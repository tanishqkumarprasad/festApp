import 'package:equatable/equatable.dart';

sealed class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object?> get props => [];
}

class SubmitRegistration extends RegistrationEvent {
  final String eventId;
  final Map<String, dynamic> userData;

  const SubmitRegistration({
    required this.eventId,
    required this.userData,
  });

  @override
  List<Object?> get props => [eventId, userData];
}