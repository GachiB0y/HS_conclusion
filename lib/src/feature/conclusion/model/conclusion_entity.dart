import 'package:freezed_annotation/freezed_annotation.dart';
part 'conclusion_entity.freezed.dart';
part 'conclusion_entity.g.dart';

@freezed
class ConclusionBarcodeModel with _$ConclusionBarcodeModel {
  const factory ConclusionBarcodeModel({
    required List<String> listBarcodes,
  }) = _ConclusionBarcodeModel;

  factory ConclusionBarcodeModel.fromJson(Map<String, dynamic> json) =>
      _$ConclusionBarcodeModelFromJson(json);
}
