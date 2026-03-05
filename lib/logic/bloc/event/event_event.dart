import 'package:equatable/equatable.dart';

enum EventCategoryFilter { all, live, upcoming, custom }

sealed class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object?> get props => [];
}

/// Fetches events from Firestore when the app / screen opens.
class FetchEvents extends EventEvent {
  const FetchEvents();
}

/// Updates the in-memory list by category or status.
class FilterEventsByCategory extends EventEvent {
  final EventCategoryFilter filter;
  final String? customCategory;

  const FilterEventsByCategory({
    required this.filter,
    this.customCategory,
  });

  @override
  List<Object?> get props => [filter, customCategory];
}

/// Explicit manual refresh – e.g. pull-to-refresh.
class RefreshEvents extends EventEvent {
  const RefreshEvents();
}

