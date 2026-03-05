import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/event_model.dart';
import '../../../data/repositories/event_repository.dart';
import 'event_event.dart';
import 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final EventRepository _eventRepository;
  List<EventModel> _allEvents = const [];

  EventBloc({EventRepository? eventRepository})
      : _eventRepository = eventRepository ?? EventRepository(),
        super(const EventLoading()) {
    on<FetchEvents>(_onFetchEvents);
    on<RefreshEvents>(_onRefreshEvents);
    on<FilterEventsByCategory>(_onFilterEventsByCategory);
  }

  Future<void> _onFetchEvents(
    FetchEvents event,
    Emitter<EventState> emit,
  ) async {
    emit(const EventLoading());
    try {
      _allEvents = await _eventRepository.fetchEvents();
      if (_allEvents.isEmpty) {
        emit(const EventEmpty());
      } else {
        emit(EventLoaded(_allEvents));
      }
    } on FirebaseException catch (e) {
      emit(EventError(e.message ?? 'Unable to load events'));
    } catch (_) {
      emit(const EventError('Unable to load events'));
    }
  }

  Future<void> _onRefreshEvents(
    RefreshEvents event,
    Emitter<EventState> emit,
  ) async {
    await _onFetchEvents(const FetchEvents(), emit);
  }

  Future<void> _onFilterEventsByCategory(
    FilterEventsByCategory event,
    Emitter<EventState> emit,
  ) async {
    if (_allEvents.isEmpty) {
      emit(const EventEmpty());
      return;
    }

    List<EventModel> filtered = _allEvents;

    switch (event.filter) {
      case EventCategoryFilter.all:
        filtered = _allEvents;
        break;
      case EventCategoryFilter.live:
        filtered =
            _allEvents.where((EventModel e) => e.isLive).toList(growable: false);
        break;
      case EventCategoryFilter.upcoming:
        filtered = _allEvents
            .where(
              (EventModel e) =>
                  !e.isLive ||
                  (e.startAt != null &&
                      e.startAt!.isAfter(DateTime.now())),
            )
            .toList(growable: false);
        break;
      case EventCategoryFilter.custom:
        final cat = (event.customCategory ?? '').trim().toLowerCase();
        if (cat.isEmpty) {
          filtered = _allEvents;
        } else {
          filtered = _allEvents
              .where(
                (EventModel e) => e.category.trim().toLowerCase() == cat,
              )
              .toList(growable: false);
        }
        break;
    }

    if (filtered.isEmpty) {
      emit(const EventEmpty());
    } else {
      emit(EventLoaded(filtered));
    }
  }
}

