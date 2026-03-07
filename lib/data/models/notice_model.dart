
import 'package:cloud_firestore/cloud_firestore.dart';

class NoticeModel {
  final String id;
  final String eventName;
  final String otherDetails;
  final String imageUrl;
  final String rulebookPdfUrl;
  final String registrationLink;
  final DateTime? createdAt;
  final DateTime? eventDate;

  NoticeModel({
    required this.id,
    required this.eventName,
    required this.otherDetails,
    required this.imageUrl,
    required this.rulebookPdfUrl,
    required this.registrationLink,
    this.createdAt,
    this.eventDate,
  });

  factory NoticeModel.fromMap(Map<String, dynamic> map, String id) {
    return NoticeModel(
      id: id,
      eventName: map['eventName'] ?? '',
      otherDetails: map['otherDetails'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      rulebookPdfUrl: map['rulebookPdfUrl'] ?? '',
      registrationLink: map['registrationLink'] ?? '',
      createdAt: map['createdAt'] != null ? (map['createdAt'] as Timestamp).toDate() : null,
      eventDate: map['eventDate'] != null ? (map['eventDate'] as Timestamp).toDate() : null,
    );
  }
}