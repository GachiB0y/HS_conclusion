import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hs_conclusion/src/feature/replacement/data/replacement_repository.dart';
import 'package:hs_conclusion/src/feature/replacement/model/replacement_view_model/replacement_view_model.dart';

part 'replacement_view_model_bloc.freezed.dart';
part 'replacement_view_model_event.dart';
part 'replacement_view_model_state.dart';

/// Business Logic Component ReplacementViewModelBLoC
class ReplacementViewModelBLoC
    extends Bloc<ReplacementViewModelEvent, ReplacementViewModelState>
    implements EventSink<ReplacementViewModelEvent> {
  ReplacementViewModelBLoC({
    required final IReplacementRepository repository,
    final ReplacementViewModelState? initialState,
  })  : _repository = repository,
        super(
          initialState ??
              const ReplacementViewModelState.idle(
                data: ReplacementViewModel(isShowDialogAddBarcodesItems: false),
                message: 'Initial idle state',
              ),
        ) {
    _stateSubscription = _repository
        .getShowDialogAddBarcodesItems()
        .map(
          (status) =>
              ReplacementViewModel(isShowDialogAddBarcodesItems: status),
        )
        .where((newState) => newState != state.data)
        .listen((status) {
      emit(
        ReplacementViewModelState.successful(
          data: state.data!.copyWith(
            isShowDialogAddBarcodesItems: status.isShowDialogAddBarcodesItems,
          ),
        ),
      );
      emit(
        ReplacementViewModelState.idle(
          data: state.data!.copyWith(isShowDialogAddBarcodesItems: false),
        ),
      );
    });
    on<ReplacementViewModelEvent>(
      (event, emit) => event.map<Future<void>>(
        changeIsShowDialogAddBarcodesItems: (event) => _change(event, emit),
      ),
      transformer: bloc_concurrency.sequential(),
      //transformer: bloc_concurrency.restartable(),
      //transformer: bloc_concurrency.droppable(),
      //transformer: bloc_concurrency.concurrent(),
    );
  }

  final IReplacementRepository _repository;
  StreamSubscription<ReplacementViewModel>? _stateSubscription;

  @override
  Future<void> close() async {
    await _stateSubscription?.cancel();
    return super.close();
  }

  /// Change event handler
  Future<void> _change(
    ChangeIsShowDialogAddBarcodesItemsReplacementViewModelEvent event,
    Emitter<ReplacementViewModelState> emit,
  ) async {
    try {
      emit(ReplacementViewModelState.processing(data: state.data));
      final newData = await _repository.fetch(barcode: '');
      emit(
        ReplacementViewModelState.successful(
          data: state.data!.copyWith(isShowDialogAddBarcodesItems: true),
        ),
      );
    } on Object catch (err, stackTrace) {
      //l.e('An error occurred in the ReplacementViewModelBLoC: $err', stackTrace);
      emit(ReplacementViewModelState.error(data: state.data));
      rethrow;
    } finally {
      emit(
        ReplacementViewModelState.idle(
          data: state.data!.copyWith(isShowDialogAddBarcodesItems: false),
        ),
      );
    }
  }
}
