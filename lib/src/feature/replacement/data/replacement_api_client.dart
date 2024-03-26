import 'package:hs_conclusion/src/core/components/rest_client/rest_client.dart';
import 'package:hs_conclusion/src/feature/replacement/bloc/replacement_bloc.dart';
import 'package:hs_conclusion/src/feature/replacement/model/pallet_model.dart';

abstract interface class IReplacementApiClient {
  Future<ReplacementEntity> fetch({required String barcode});
  Future<Box> findBox({required String barcode});
}

class ReplacmentBarcodeApiClient implements IReplacementApiClient {
  final RestClient _httpService;
  ReplacmentBarcodeApiClient(
    this._httpService,
  );

  @override
  Future<ReplacementEntity> fetch({required String barcode}) async {
    // final response = await _httpService.get(
    //   '/conclusion',
    // );

    final data = {
      "barcode": barcode,
      "countItemInBox": 4,
      "boxes": [
        {
          "barcode": "043456789123456783",
          "items": [
            {"barcode": "item1"},
            {"barcode": "item2"},
            {"barcode": "item3"},
            {"barcode": "item4"},
          ],
        },
        {
          "barcode": "043456789123456782",
          "items": [
            {"barcode": "item1"},
            {"barcode": "item2"},
            {"barcode": "item3"},
            {"barcode": "item4"},
          ],
        }
      ],
    };
    final result = ReplacementEntity.fromJson(data);
    return result;
  }

  @override
  Future<Box> findBox({required String barcode}) async {
    // final response = await _httpService.get(
    //   '/conclusion',
    // );
    if (barcode == '043456789123456784') {
      final data = {
        "barcode": 043456789123456784,
        "items": [
          {"barcode": "item1"},
          {"barcode": "item2"},
          {"barcode": "item3"},
          {"barcode": "item4"},
        ],
      };
      return Box.fromJson(data);
    } else {
      return Box(barcode: barcode, items: []);
    }
  }
}
