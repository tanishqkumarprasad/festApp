import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

enum NoticeContentTypeModel { text, image, pdf }

class NoticeModel extends Equatable {
  final String id;
  final String subject;
  final String description;
  final String authority;
  final NoticeContentTypeModel contentType;
  final String content; // could be plain text or a URL to file
  final DateTime? createdAt;

  const NoticeModel({
    required this.id,
    required this.subject,
    required this.description,
    required this.authority,
    required this.contentType,
    required this.content,
    this.createdAt,
  });

  static NoticeContentTypeModel _parseType(String? raw) {
    final v = (raw ?? '').toLowerCase();
    switch (v) {
      case 'image':
        return NoticeContentTypeModel.image;
      case 'pdf':
        return NoticeContentTypeModel.pdf;
      case 'text':
      default:
        return NoticeContentTypeModel.text;
    }
  }

  static DateTime? _toDateTime(dynamic v) {
    if (v == null) return null;
    if (v is DateTime) return v;
    if (v is Timestamp) return v.toDate();
    return null;
  }

  factory NoticeModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? <String, dynamic>{};
    return NoticeModel(
      id: doc.id,
      subject: (data['subject'] as String?)?.trim() ?? '',
      description: (data['description'] as String?)?.trim() ?? '',
      authority: (data['authority'] as String?)?.trim() ?? '',
      contentType: _parseType(data['contentType'] as String?),
      content: (data['content'] as String?)?.trim() ?? '',
      createdAt: _toDateTime(data['createdAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'subject': subject,
      'description': description,
      'authority': authority,
      'contentType': switch (contentType) {
        NoticeContentTypeModel.text => 'text',
        NoticeContentTypeModel.image => 'image',
        NoticeContentTypeModel.pdf => 'pdf',
      },
      'content': content,
      'createdAt': createdAt,
    };
  }

  @override
  List<Object?> get props =>
      [id, subject, description, authority, contentType, content, createdAt];
}

