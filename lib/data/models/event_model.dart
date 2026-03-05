import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class EventModel extends Equatable {
  final String id;
  final String title;
  final String category;
  final String status; // 'live' | 'upcoming' | any custom value
  final DateTime? startAt;
  final DateTime? endAt;

  const EventModel({
    required this.id,
    required this.title,
    required this.category,
    required this.status,
    this.startAt,
    this.endAt,
  });

  bool get isLive => status.trim().toLowerCase() == 'live';

  static DateTime? _toDateTime(dynamic v) {
    if (v == null) return null;
    if (v is DateTime) return v;
    if (v is Timestamp) return v.toDate();
    return null;
  }

  factory EventModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? <String, dynamic>{};
    return EventModel(
      id: doc.id,
      title: (data['title'] as String?)?.trim() ?? '',
      category: (data['category'] as String?)?.trim() ?? 'general',
      status: (data['status'] as String?)?.trim() ?? 'upcoming',
      startAt: _toDateTime(data['startAt']),
      endAt: _toDateTime(data['endAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'category': category,
      'status': status,
      'startAt': startAt,
      'endAt': endAt,
    };
  }

  @override
  List<Object?> get props => [id, title, category, status, startAt, endAt];
}

