import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../dataproviders/firestore_provider.dart';
import '../models/coordinator_model.dart';

class CoordinatorRepository {
  final FirestoreProvider _firestoreProvider;

  CoordinatorRepository({FirestoreProvider? firestoreProvider})
      : _firestoreProvider = firestoreProvider ?? FirestoreProvider();

  Future<List<CoordinatorModel>> fetchCoordinators() async {
    final query = await _firestoreProvider.coordinatorsCollection().get();

    return query.docs
        .map(CoordinatorModel.fromFirestore)
        .toList(growable: false);
  }

  Stream<List<CoordinatorModel>> watchCoordinators() {
    return _firestoreProvider
        .coordinatorsCollection()
        .snapshots()
        .map(
          (QuerySnapshot<Map<String, dynamic>> snap) => snap.docs
              .map(CoordinatorModel.fromFirestore)
              .toList(growable: false),
        );
  }
}