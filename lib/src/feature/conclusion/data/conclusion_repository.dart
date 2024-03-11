import 'package:hs_conclusion/src/feature/conclusion/bloc/conclusion_barcode_bloc.dart';
import 'package:hs_conclusion/src/feature/conclusion/data/conclusion_api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class IConclusionBarcodeRepository {
  Future<void> sendBarcodeConclusion(ConclusionBarcodeEntity listBarcodes);
  Future<void> saveBarcodesConclusion(String barcode);
  Future<void> removeAllBarcodesConclusion();
  Future<List<String>> getBarcodesConclusion();
}

class ConclusionBarcodeRepository implements IConclusionBarcodeRepository {
  ConclusionBarcodeRepository({
    required IConclusionBarcodeApiClient provider,
    required SharedPreferences sharedPreferences,
  })  : _provider = provider,
        _sharedPreferences = sharedPreferences;

  final IConclusionBarcodeApiClient _provider;

  final SharedPreferences _sharedPreferences;

  List<String>? _barcodesConclusionCache;

  static const String _barcodesConclusionProductsKey =
      'barcodes.conclusion.list';

  @override
  Future<void> sendBarcodeConclusion(ConclusionBarcodeEntity listBarcodes) =>
      _provider.sendBarcodeConclusion(listBarcodes);

  @override
  Future<void> saveBarcodesConclusion(String barcode) async {
    final list = await getBarcodesConclusion();
    list.add(barcode);
    _barcodesConclusionCache = list;
    await _sharedPreferences.setStringList(
      _barcodesConclusionProductsKey,
      <String>[
        ...list,
        barcode,
      ],
    );
  }

  @override
  Future<List<String>> getBarcodesConclusion() async {
    if (_barcodesConclusionCache case final List<String> cache) {
      return List<String>.of(cache);
    }
    final list =
        _sharedPreferences.getStringList(_barcodesConclusionProductsKey);
    if (list == null) return <String>[];
    return List<String>.of(
      _barcodesConclusionCache = list,
    );
  }

  @override
  Future<void> removeAllBarcodesConclusion() async {
    final list = await getBarcodesConclusion();
    list.clear();
    _barcodesConclusionCache = list;
    await _sharedPreferences.setStringList(
      _barcodesConclusionProductsKey,
      <String>[...list],
    );
  }
}
