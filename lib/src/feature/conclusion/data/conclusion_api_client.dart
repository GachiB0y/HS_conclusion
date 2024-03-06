import 'package:hs_conclusion/src/core/components/rest_client/rest_client.dart';
import 'package:hs_conclusion/src/feature/conclusion/bloc/conclusion_barcode_bloc.dart';
import 'package:hs_conclusion/src/feature/conclusion/model/conclusion_entity.dart';

abstract interface class IConclusionBarcodeApiClient {
  Future<void> sendBarcodeConclusion(ConclusionBarcodeEntity listBarcodes);
}

class ConclusionBarcodeApiClient implements IConclusionBarcodeApiClient {
  final RestClient _httpService;
  ConclusionBarcodeApiClient(
    this._httpService,
  );

  @override
  Future<void> sendBarcodeConclusion(
    ConclusionBarcodeEntity listBarcodes,
  ) async {
    final body = ConclusionBarcodeModel(listBarcodes: listBarcodes);

    final response = await _httpService.post(
      '/conclusion',
      body: {'data': '${body.toJson()}'},
    );
  }
}
