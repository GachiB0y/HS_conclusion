part of 'conclusion_barcode_bloc.dart';

/// Business Logic Component ConclusionBarcode Events
@freezed
class ConclusionBarcodeEvent with _$ConclusionBarcodeEvent {
  const ConclusionBarcodeEvent._();

  /// Create
  const factory ConclusionBarcodeEvent.create({required String barcode}) =
      CreateConclusionBarcodeEvent;

  /// sendBarcodeConclusion
  const factory ConclusionBarcodeEvent.sendBarcodeConclusion() =
      SendBarcodeConclusionConclusionBarcodeEvent;

  /// fetchBarcodesConclusion
  const factory ConclusionBarcodeEvent.fetchBarcodesConclusion() =
      FetchBarcodesConclusionBarcodeEvent;

  // /// Update
  // const factory ConclusionBarcodeEvent.update({required Item item}) =
  //     UpdateConclusionBarcodeEvent;

  // /// Delete
  // const factory ConclusionBarcodeEvent.delete({required Item item}) =
  //     DeleteConclusionBarcodeEvent;
}
