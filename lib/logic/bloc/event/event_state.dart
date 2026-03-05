import 'package:equatable/equatable.dart';

import '../../../data/models/event_model.dart';

sealed class EventState extends Equatable {
  const EventState();

  @override
  List<Object?> get props => [];
}

/// Triggered when app/screen first opens.
class EventLoading extends EventState {
  const EventLoading();
}

/// There are events loaded successfully.
class EventLoaded extends EventState {
  final List<EventModel> events;

  const EventLoaded(this.events);

  @override
  List<Object?> get props => [events];
}

/// No events posted yet.
class EventEmpty extends EventState {
  const EventEmpty();
}

/// Error while talking to Firestore / network.
class EventError extends EventState {
  final String message;

  const EventError(this.message);

  @override
  List<Object?> get props => [message];
}

