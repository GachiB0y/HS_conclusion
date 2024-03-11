import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hs_conclusion/src/feature/conclusion/data/conclusion_repository.dart';

part 'conclusion_barcode_bloc.freezed.dart';
part 'conclusion_barcode_event.dart';
part 'conclusion_barcode_state.dart';

/// Business Logic Component ConclusionBarcodeBLoC
class ConclusionBarcodeBLoC
    extends Bloc<ConclusionBarcodeEvent, ConclusionBarcodeState>
    implements EventSink<ConclusionBarcodeEvent> {
  ConclusionBarcodeBLoC({
    required final IConclusionBarcodeRepository repository,
    final ConclusionBarcodeState? initialState,
  })  : _repository = repository,
        super(
          initialState ??
              const ConclusionBarcodeState.idle(
                data: [],
                message: 'Initial idle state',
              ),
        ) {
    on<ConclusionBarcodeEvent>(
      (event, emit) => event.map<Future<void>>(
        create: (event) => _create(event, emit),
        sendBarcodeConclusion: (event) => _sendBarcodesConclusion(event, emit),
        fetchBarcodesConclusion: (event) =>
            _fetchBarcodesConclusion(event, emit),
      ),
      transformer: bloc_concurrency.sequential(),
      //transformer: bloc_concurrency.restartable(),
      //transformer: bloc_concurrency.droppable(),
      //transformer: bloc_concurrency.concurrent(),
    );
  }

  final IConclusionBarcodeRepository _repository;

  /// Create event handler
  Future<void> _create(
    CreateConclusionBarcodeEvent event,
    Emitter<ConclusionBarcodeState> emit,
  ) async {
    try {
      emit(ConclusionBarcodeState.processing(data: state.data));

      final List<String> newData = [...state.data!, event.barcode];
      await _repository.saveBarcodesConclusion(event.barcode);

      emit(ConclusionBarcodeState.successful(data: newData));
      print('newData: $newData');
    } on Object catch (err, stackTrace) {
      //l.e('An error occurred in the ConclusionBarcodeBLoC: $err', stackTrace);
      emit(ConclusionBarcodeState.error(data: state.data));
      rethrow;
    } finally {
      emit(ConclusionBarcodeState.idle(data: state.data));
    }
  }

  /// Fetch Barcodes Conclusion event handler
  Future<void> _fetchBarcodesConclusion(
    FetchBarcodesConclusionBarcodeEvent event,
    Emitter<ConclusionBarcodeState> emit,
  ) async {
    try {
      emit(ConclusionBarcodeState.processing(data: state.data));

      final List<String> newData = await _repository.getBarcodesConclusion();

      emit(ConclusionBarcodeState.successful(data: newData));
    } on Object catch (err, stackTrace) {
      //l.e('An error occurred in the ConclusionBarcodeBLoC: $err', stackTrace);
      emit(ConclusionBarcodeState.error(data: state.data));
      rethrow;
    } finally {
      emit(ConclusionBarcodeState.idle(data: state.data));
    }
  }

  /// Send barcodes conclusion event handler
  Future<void> _sendBarcodesConclusion(
    SendBarcodeConclusionConclusionBarcodeEvent event,
    Emitter<ConclusionBarcodeState> emit,
  ) async {
    try {
      // emit(ConclusionBarcodeState.processing(data: state.data));
      // final newData = await _repository.fetch(event.barcode);
      await _repository.removeAllBarcodesConclusion();
      emit(const ConclusionBarcodeState.successful(data: []));
    } on Object catch (err, stackTrace) {
      //l.e('An error occurred in the ConclusionBarcodeBLoC: $err', stackTrace);
      emit(ConclusionBarcodeState.error(data: state.data));
      rethrow;
    } finally {
      emit(ConclusionBarcodeState.idle(data: state.data));
    }
  }
}
