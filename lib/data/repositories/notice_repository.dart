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

    // UPDATE: Now correctly uses the fromMap constructor and passes the document ID
    return query.docs
        .map((doc) => NoticeModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList(growable: false);
  }

  Stream<List<NoticeModel>> watchNotices() {
    return _firestoreProvider
        .noticesCollection()
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (QuerySnapshot<Map<String, dynamic>> snap) => snap.docs
          .map((doc) => NoticeModel.fromMap(doc.data(), doc.id))
          .toList(growable: false),
    );
  }
}