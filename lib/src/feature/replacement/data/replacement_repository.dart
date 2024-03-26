import 'package:hs_conclusion/src/feature/replacement/bloc/replacement_bloc.dart';
import 'package:hs_conclusion/src/feature/replacement/data/replacement_api_client.dart';
import 'package:hs_conclusion/src/feature/replacement/model/pallet_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class IReplacementRepository {
  Future<ReplacementEntity> fetch({required String barcode});
  Future<Box> findBox({required String barcode});
}

class ReplacementRepository implements IReplacementRepository {
  ReplacementRepository({
    required IReplacementApiClient provider,
    required SharedPreferences sharedPreferences,
  })  : _sharedPreferences = sharedPreferences,
        _provider = provider;

  final IReplacementApiClient _provider;
  final SharedPreferences _sharedPreferences;

  @override
  Future<ReplacementEntity> fetch({required String barcode}) =>
      _provider.fetch(barcode: barcode);

  @override
  Future<Box> findBox({required String barcode}) =>
      _provider.findBox(barcode: barcode);
}
