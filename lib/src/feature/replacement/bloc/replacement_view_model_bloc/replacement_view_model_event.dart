part of 'replacement_view_model_bloc.dart';

/// Business Logic Component ReplacementViewModel Events
@freezed
class ReplacementViewModelEvent with _$ReplacementViewModelEvent {
  const ReplacementViewModelEvent._();

  /// Change is show dialog add barcodes items
  const factory ReplacementViewModelEvent.changeIsShowDialogAddBarcodesItems({
    required bool isShow,
  }) = ChangeIsShowDialogAddBarcodesItemsReplacementViewModelEvent;
}
