import 'dart:async';

import 'package:hs_conclusion/src/feature/replacement/bloc/replacement_bloc/replacement_bloc.dart';
import 'package:hs_conclusion/src/feature/replacement/data/replacement_api_client.dart';
import 'package:hs_conclusion/src/feature/replacement/model/pallet_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class IReplacementRepository {
  Future<ReplacementEntity> fetch({required String barcode});
  Future<Box> findBox({required String barcode});
  Stream<bool> getShowDialogAddBarcodesItems();
}

class ReplacementRepository implements IReplacementRepository {
  ReplacementRepository({
    required IReplacementApiClient provider,
    required SharedPreferences sharedPreferences,
  })  : _sharedPreferences = sharedPreferences,
        _provider = provider;

  final IReplacementApiClient _provider;
  final SharedPreferences _sharedPreferences;
  final _boolController = StreamController<bool>();

  @override
  Future<ReplacementEntity> fetch({required String barcode}) =>
      _provider.fetch(barcode: barcode);

  @override
  Future<Box> findBox({required String barcode}) async {
    final box = await _provider.findBox(barcode: barcode);
    if (box.items.isEmpty) {
      _boolController.add(true);
    }
    return box;
  }

  @override
  Stream<bool> getShowDialogAddBarcodesItems() => _boolController.stream;
}
