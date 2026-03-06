import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../dataproviders/firestore_provider.dart';
import '../models/notice_model.dart';

class NoticeRepository {
  final FirestoreProvider _firestoreProvider;

  NoticeRepository({FirestoreProvider? firestoreProvider})
      : _firestoreProvider = firestoreProvider ?? FirestoreProvider();

  Future<List<NoticeModel>> fetchNotices() async {
    final query = await _firestoreProvider
        .noticesCollection()
        .orderBy('createdAt', descending: true)
        .get();

    return query.docs
        .map(NoticeModel.fromFirestore)
        .toList(growable: false);
  }

  Stream<List<NoticeModel>> watchNotices() {
    return _firestoreProvider
        .noticesCollection()
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (QuerySnapshot<Map<String, dynamic>> snap) => snap.docs
              .map(NoticeModel.fromFirestore)
              .toList(growable: false),
        );
  }
}

