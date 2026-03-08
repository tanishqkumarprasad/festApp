import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/coordinator_model.dart';
import '../../../data/repositories/coordinator_repository.dart';
import 'coordinator_event.dart';
import 'coordinator_state.dart';

class CoordinatorBloc extends Bloc<CoordinatorEvent, CoordinatorState> {
  final CoordinatorRepository? _coordinatorRepository;
  final bool _useRepository;
  List<CoordinatorModel> _allCoordinators = const [];

  CoordinatorBloc({
    CoordinatorRepository? coordinatorRepository,
    bool useRepository = true,
  })  : _useRepository = useRepository,
        _coordinatorRepository =
            useRepository ? (coordinatorRepository ?? CoordinatorRepository()) : null,
        super(const CoordinatorLoading()) {
    on<FetchCoordinators>(_onFetchCoordinators);
    on<RefreshCoordinators>(_onRefreshCoordinators);
  }

  Future<void> _onFetchCoordinators(
    FetchCoordinators event,
    Emitter<CoordinatorState> emit,
  ) async {
    if (!_useRepository) {
      _allCoordinators = const [];
      emit(const CoordinatorEmpty());
      return;
    }

    emit(const CoordinatorLoading());
    try {
      _allCoordinators = await _coordinatorRepository!.fetchCoordinators();
      if (_allCoordinators.isEmpty) {
        emit(const CoordinatorEmpty());
      } else {
        emit(CoordinatorLoaded(_allCoordinators));
      }
    } on FirebaseException catch (e) {
      emit(CoordinatorError(e.message ?? 'Unable to load coordinators'));
    } catch (_) {
      emit(const CoordinatorError('Unable to load coordinators'));
    }
  }

  Future<void> _onRefreshCoordinators(
    RefreshCoordinators event,
    Emitter<CoordinatorState> emit,
  ) async {
    if (!_useRepository) return;

    try {
      _allCoordinators = await _coordinatorRepository!.fetchCoordinators();
      if (_allCoordinators.isEmpty) {
        emit(const CoordinatorEmpty());
      } else {
        emit(CoordinatorLoaded(_allCoordinators));
      }
    } on FirebaseException catch (e) {
      emit(CoordinatorError(e.message ?? 'Unable to refresh coordinators'));
    } catch (_) {
      emit(const CoordinatorError('Unable to refresh coordinators'));
    }
  }
}