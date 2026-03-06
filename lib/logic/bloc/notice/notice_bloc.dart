import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/notice_model.dart';
import '../../../data/repositories/notice_repository.dart';
import 'notice_event.dart';
import 'notice_state.dart';

class NoticeBloc extends Bloc<NoticeEvent, NoticeState> {
  final NoticeRepository? _noticeRepository;
  final bool _useRepository;
  List<NoticeModel> _allNotices = const [];

  NoticeBloc({
    NoticeRepository? noticeRepository,
    bool useRepository = true,
  })  : _useRepository = useRepository,
        _noticeRepository =
            useRepository ? (noticeRepository ?? NoticeRepository()) : null,
        super(const NoticeLoading()) {
    on<FetchNotices>(_onFetchNotices);
  }

  Future<void> _onFetchNotices(
    FetchNotices event,
    Emitter<NoticeState> emit,
  ) async {
    if (!_useRepository) {
      _allNotices = const [];
      emit(const NoticeEmpty());
      return;
    }

    emit(const NoticeLoading());
    try {
      _allNotices = await _noticeRepository!.fetchNotices();
      if (_allNotices.isEmpty) {
        emit(const NoticeEmpty());
      } else {
        emit(NoticeLoaded(_allNotices));
      }
    } on FirebaseException catch (e) {
      emit(NoticeError(e.message ?? 'Unable to load notices'));
    } catch (_) {
      emit(const NoticeError('Unable to load notices'));
    }
  }
}

