import 'package:hs_conclusion/src/feature/conclusion/bloc/conclusion_barcode_bloc.dart';
import 'package:hs_conclusion/src/feature/conclusion/data/conclusion_api_client.dart';

abstract interface class IConclusionBarcodeRepository {
  Future<void> sendBarcodeConclusion(ConclusionBarcodeEntity listBarcodes);
}

class ConclusionBarcodeRepository implements IConclusionBarcodeRepository {
  const ConclusionBarcodeRepository({
    required IConclusionBarcodeApiClient provider,
  }) : _provider = provider;

  final IConclusionBarcodeApiClient _provider;
  @override
  Future<void> sendBarcodeConclusion(ConclusionBarcodeEntity listBarcodes) =>
      _provider.sendBarcodeConclusion(listBarcodes);
}
