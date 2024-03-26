part of 'replacement_bloc.dart';

/// Business Logic Component Replacement Events
@freezed
class ReplacementEvent with _$ReplacementEvent {
  const ReplacementEvent._();

  /// Create
  const factory ReplacementEvent.create({required String barcode}) =
      CreateReplacementEvent;

  /// Fetch
  const factory ReplacementEvent.fetch({required String barcode}) =
      FetchReplacementEvent;

  /// Update
  const factory ReplacementEvent.update({
    required int indexBox,
    required List<Item> item,
  }) = UpdateReplacementEvent;

  /// Delete
  const factory ReplacementEvent.delete({
    required int indexBox,
  }) = DeleteReplacementEvent;
}
