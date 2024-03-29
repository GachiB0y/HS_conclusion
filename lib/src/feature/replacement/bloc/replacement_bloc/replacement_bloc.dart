// ignore_for_file: unused_catch_stack

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hs_conclusion/src/feature/replacement/data/replacement_repository.dart';
import 'package:hs_conclusion/src/feature/replacement/model/pallet_model.dart';
import 'package:meta/meta.dart';

part 'replacement_bloc.freezed.dart';
part 'replacement_event.dart';
part 'replacement_state.dart';

/// Business Logic Component ReplacementBLoC
class ReplacementBLoC extends Bloc<ReplacementEvent, ReplacementState>
    implements EventSink<ReplacementEvent> {
  ReplacementBLoC({
    required final IReplacementRepository repository,
    final ReplacementState? initialState,
  })  : _repository = repository,
        super(
          initialState ??
              const ReplacementState.idle(
                data: null,
                message: 'Initial idle state',
              ),
        ) {
    on<ReplacementEvent>(
      (event, emit) => event.map<Future<void>>(
        fetch: (event) => _fetch(event, emit),
        update: (event) => _update(event, emit),
        delete: (event) => _delete(event, emit),
        create: (event) => _create(event, emit),
        getCash: (event) => _getCash(event, emit),
        sendPallet: (event) => _sendPallet(event, emit),
      ),
      transformer: bloc_concurrency.sequential(),
      //transformer: bloc_concurrency.restartable(),
      //transformer: bloc_concurrency.droppable(),
      //transformer: bloc_concurrency.concurrent(),
    );
  }

  final IReplacementRepository _repository;

  /// Fetch event handler
  Future<void> _fetch(
    FetchReplacementEvent event,
    Emitter<ReplacementState> emit,
  ) async {
    try {
      emit(ReplacementState.processing(data: state.data));
      final newData = await _repository.fetch(barcode: event.barcode);
      await _repository.savePallet(newData);
      emit(ReplacementState.successful(data: newData));
    } on Object catch (err, stackTrace) {
      //l.e('An error occurred in the ReplacementBLoC: $err', stackTrace);
      emit(ReplacementState.error(data: state.data));
      rethrow;
    } finally {
      emit(ReplacementState.idle(data: state.data));
    }
  }

  /// Update event handler
  Future<void> _update(
    UpdateReplacementEvent event,
    Emitter<ReplacementState> emit,
  ) async {
    try {
      final oldData = state.data!.copyWith();
      final oldBoxes = [...oldData.boxes];
      final oldItems = [...oldBoxes[event.indexBox].items];
      oldItems.clear();
      oldItems.addAll(event.item);
      oldBoxes[event.indexBox] = oldBoxes[event.indexBox].copyWith(
        items: oldItems,
      );

      final newData = oldData.copyWith(boxes: oldBoxes);
      await _repository.savePallet(newData);
      emit(ReplacementState.successful(data: newData));
    } on Object catch (err, stackTrace) {
      //l.e('An error occurred in the ReplacementBLoC: $err', stackTrace);
      emit(ReplacementState.error(data: state.data));
      rethrow;
    } finally {
      emit(ReplacementState.idle(data: state.data));
    }
  }

  /// Delete event handler
  Future<void> _delete(
    DeleteReplacementEvent event,
    Emitter<ReplacementState> emit,
  ) async {
    try {
      final oldData = state.data!.copyWith();
      final oldBoxes = [...oldData.boxes];

      oldBoxes.remove(oldBoxes[event.indexBox]);

      final newData = oldData.copyWith(boxes: oldBoxes);
      await _repository.savePallet(newData);
      emit(ReplacementState.successful(data: newData));
    } on Object catch (err, stackTrace) {
      //l.e('An error occurred in the ReplacementBLoC: $err', stackTrace);
      emit(ReplacementState.error(data: state.data));
      rethrow;
    } finally {
      emit(ReplacementState.idle(data: state.data));
    }
  }

  /// Create event handler
  Future<void> _create(
    CreateReplacementEvent event,
    Emitter<ReplacementState> emit,
  ) async {
    try {
      emit(ReplacementState.processing(data: state.data));
      final box = await _repository.findBox(barcode: event.barcode);

      final oldData = state.data!.copyWith();
      final oldBoxes = [...oldData.boxes];

      oldBoxes.add(box);

      final newData = oldData.copyWith(boxes: oldBoxes);
      await _repository.savePallet(newData);
      emit(ReplacementState.successful(data: newData));
    } on Object catch (err, stackTrace) {
      //l.e('An error occurred in the ReplacementBLoC: $err', stackTrace);
      emit(ReplacementState.error(data: state.data));
      rethrow;
    } finally {
      emit(ReplacementState.idle(data: state.data));
    }
  }

  /// Get Cash event handler
  Future<void> _getCash(
    GetCashReplacementEvent event,
    Emitter<ReplacementState> emit,
  ) async {
    try {
      emit(ReplacementState.processing(data: state.data));
      final pallet = await _repository.getPallets();

      emit(ReplacementState.successful(data: pallet));
    } on Object catch (err, stackTrace) {
      //l.e('An error occurred in the ReplacementBLoC: $err', stackTrace);
      emit(ReplacementState.error(data: state.data));
      rethrow;
    } finally {
      emit(ReplacementState.idle(data: state.data));
    }
  }

  /// Send Pallet event handler
  Future<void> _sendPallet(
    SendPalletReplacementEvent event,
    Emitter<ReplacementState> emit,
  ) async {
    try {
      emit(ReplacementState.processing(data: state.data));
      await _repository.removeAllPallets();

      emit(const ReplacementState.successful(data: null));
    } on Object catch (err, stackTrace) {
      //l.e('An error occurred in the ReplacementBLoC: $err', stackTrace);
      emit(ReplacementState.error(data: state.data));
      rethrow;
    } finally {
      emit(ReplacementState.idle(data: state.data));
    }
  }
}
