import 'package:equatable/equatable.dart';

abstract class CoordinatorEvent extends Equatable {
  const CoordinatorEvent();

  @override
  List<Object?> get props => [];
}

class FetchCoordinators extends CoordinatorEvent {
  const FetchCoordinators();
}

class RefreshCoordinators extends CoordinatorEvent {
  const RefreshCoordinators();
}