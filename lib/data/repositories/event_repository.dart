import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../dataproviders/firestore_provider.dart';
import '../models/event_model.dart';

class EventRepository {
  final FirestoreProvider _firestoreProvider;

  EventRepository({FirestoreProvider? firestoreProvider})
      : _firestoreProvider = firestoreProvider ?? FirestoreProvider();

  Future<List<EventModel>> fetchEvents() async {
    final query = await _firestoreProvider
        .eventsCollection()
        .orderBy('startAt', descending: false)
        .get();

    return query.docs
        .map(EventModel.fromFirestore)
        .toList(growable: false);
  }

  Stream<List<EventModel>> watchEvents() {
    return _firestoreProvider
        .eventsCollection()
        .orderBy('startAt', descending: false)
        .snapshots()
        .map(
          (QuerySnapshot<Map<String, dynamic>> snap) => snap.docs
              .map(EventModel.fromFirestore)
              .toList(growable: false),
        );
  }
}

