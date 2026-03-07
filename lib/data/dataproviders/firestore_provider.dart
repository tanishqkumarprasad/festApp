import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreProvider {
  final FirebaseFirestore _firestore;

  FirestoreProvider({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  FirebaseFirestore get instance => _firestore;

  CollectionReference<Map<String, dynamic>> eventsCollection() =>
      _firestore.collection('events');

  DocumentReference<Map<String, dynamic>> userDoc(String uid) =>
      _firestore.collection('users').doc(uid);

  CollectionReference<Map<String, dynamic>> noticesCollection() =>
      _firestore.collection('notices');

  CollectionReference<Map<String, dynamic>> coordinatorsCollection() =>
      _firestore.collection('coordinators');
}

