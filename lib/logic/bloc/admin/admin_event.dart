import 'dart:io'; // Needed for File
import 'package:equatable/equatable.dart';

sealed class AdminEvent extends Equatable {
  const AdminEvent();

  @override
  List<Object?> get props => [];
}

class CreateNewEvent extends AdminEvent {
  final Map<String, dynamic> eventData;
  const CreateNewEvent(this.eventData);
  @override
  List<Object?> get props => [eventData];
}

class PostNotice extends AdminEvent {
  final String eventName;
  final DateTime eventDate;
  final String registrationLink;
  final String otherDetails;
  final File imageFile;   // The raw image from the phone
  final File pdfFile;     // The raw PDF from the phone

  const PostNotice({
    required this.eventName,
    required this.eventDate,
    required this.registrationLink,
    required this.otherDetails,
    required this.imageFile,
    required this.pdfFile,
  });

  @override
  List<Object?> get props => [
    eventName,
    eventDate,
    registrationLink,
    otherDetails,
    imageFile,
    pdfFile,
  ];
}

class DeleteEvent extends AdminEvent {
  final String eventId;
  const DeleteEvent(this.eventId);
  @override
  List<Object?> get props => [eventId];
}