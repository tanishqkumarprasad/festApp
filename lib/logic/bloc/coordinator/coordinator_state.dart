import 'package:equatable/equatable.dart';

import '../../../data/models/coordinator_model.dart';

abstract class CoordinatorState extends Equatable {
  const CoordinatorState();

  @override
  List<Object?> get props => [];
}

class CoordinatorLoading extends CoordinatorState {
  const CoordinatorLoading();
}

class CoordinatorLoaded extends CoordinatorState {
  final List<CoordinatorModel> coordinators;

  const CoordinatorLoaded(this.coordinators);

  @override
  List<Object?> get props => [coordinators];
}

class CoordinatorEmpty extends CoordinatorState {
  const CoordinatorEmpty();
}

class CoordinatorError extends CoordinatorState {
  final String message;

  const CoordinatorError(this.message);

  @override
  List<Object?> get props => [message];
}