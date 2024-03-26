import 'package:freezed_annotation/freezed_annotation.dart';
part 'pallet_model.freezed.dart';
part 'pallet_model.g.dart';

@freezed
class ModelsPallet with _$ModelsPallet {
  const factory ModelsPallet({
    required String barcode,
    required List<Box> boxes,
    required int countItemInBox,
  }) = _ModelsPallet;

  factory ModelsPallet.fromJson(Map<String, dynamic> json) =>
      _$ModelsPalletFromJson(json);
}

@freezed
class Box with _$Box {
  const factory Box({
    required String barcode,
    required List<Item> items,
  }) = _Box;

  factory Box.fromJson(Map<String, dynamic> json) => _$BoxFromJson(json);
}

@freezed
class Item with _$Item {
  const factory Item({
    required String barcode,
  }) = _Item;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}
