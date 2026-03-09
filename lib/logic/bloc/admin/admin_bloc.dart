import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Make sure to import the Cloudinary service we created earlier!
import 'package:fest_app/services/cloudinary_service.dart';

import 'admin_event.dart';
import 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final FirebaseFirestore _firestore;
  final CloudinaryService _cloudinaryService;

  AdminBloc({
    FirebaseFirestore? firestore,
    CloudinaryService? cloudinaryService,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
  // Initialize CloudinaryService here
        _cloudinaryService = cloudinaryService ?? CloudinaryService(),
        super(const AdminIdle()) {
    on<CreateNewEvent>(_onCreateNewEvent);
    on<PostNotice>(_onPostNotice);
    on<DeleteEvent>(_onDeleteEvent);
  }

  Future<void> _onCreateNewEvent(
      CreateNewEvent event,
      Emitter<AdminState> emit,
      ) async {
    // ... (Your existing _onCreateNewEvent code remains exactly the same)
  }

  Future<void> _onPostNotice(
      PostNotice event,
      Emitter<AdminState> emit,
      ) async {
    emit(const AdminActionProgress());
    try {
      // 1. Upload Image to Cloudinary in a specific folder (if provided)
      String? imageUrl;
      if (event.imageFile != null) {
        imageUrl = await _cloudinaryService.uploadToCloudinary(
          event.imageFile!,
          'notice_images',
        );
        if (imageUrl == null) throw Exception('Image upload to Cloudinary failed');
      }

      // 2. Upload PDF to Cloudinary in a specific folder (if provided)
      String? pdfUrl;
      if (event.pdfFile != null) {
        pdfUrl = await _cloudinaryService.uploadToCloudinary(
          event.pdfFile!,
          'notice_rulebooks',
        );
        if (pdfUrl == null) throw Exception('PDF upload to Cloudinary failed');
      }

      // 3. Save all data + Cloudinary URLs to Firestore 'notices' collection
      final Map<String, dynamic> firestoreData = {
        'eventName': event.eventName,
        'eventDate': Timestamp.fromDate(event.eventDate), // Best practice for Firestore dates
        'registrationLink': event.registrationLink,
        'otherDetails': event.otherDetails,
        'createdAt': FieldValue.serverTimestamp(), // Automatically logs exact time added
      };

      if (imageUrl != null) {
        firestoreData['imageUrl'] = imageUrl;
      }
      if (pdfUrl != null) {
        firestoreData['rulebookPdfUrl'] = pdfUrl;
      }

      await _firestore.collection('notices').add(firestoreData);

      emit(const AdminActionSuccess('Notice and files posted successfully!'));
      emit(const AdminIdle());

    } on FirebaseException catch (e) {
      emit(AdminActionError(e.message ?? 'Database permission denied'));
    } catch (e) {
      // Catches the Cloudinary exceptions we threw above
      emit(AdminActionError(e.toString()));
    }
  }

  Future<void> _onDeleteEvent(
      DeleteEvent event,
      Emitter<AdminState> emit,
      ) async {
    // ... (Your existing _onDeleteEvent code remains exactly the same)
  }
}