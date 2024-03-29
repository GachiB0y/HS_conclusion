import 'dart:async';

import 'package:hs_conclusion/src/core/components/database/src/app_database.dart';
import 'package:hs_conclusion/src/feature/replacement/bloc/replacement_bloc/replacement_bloc.dart';
import 'package:hs_conclusion/src/feature/replacement/data/replacement_api_client.dart';
import 'package:hs_conclusion/src/feature/replacement/model/pallet_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class IReplacementRepository {
  Future<ReplacementEntity> fetch({required String barcode});
  Future<Box> findBox({required String barcode});
  Stream<bool> getShowDialogAddBarcodesItems();
  Future<void> savePallet(ModelsPallet pallet);
  Future<ModelsPallet?> getPallets();
  Future<void> removeAllPallets();
}

class ReplacementRepository implements IReplacementRepository {
  ReplacementRepository({
    required IReplacementApiClient provider,
    required SharedPreferences sharedPreferences,
    required AppDatabase database,
  })  : _sharedPreferences = sharedPreferences,
        _database = database,
        _provider = provider;

  final IReplacementApiClient _provider;
  final SharedPreferences _sharedPreferences;
  final AppDatabase _database;
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

  @override
  Future<ModelsPallet?> getPallets() async {
    final List<ModelsPalletsTableData> allItems =
        await _database.select(_database.modelsPalletsTable).get();

    if (allItems.isEmpty) {
      return null;
    }
    return ModelsPallet(
      barcode: allItems[0].barcode,
      countItemInBox: allItems[0].countItemInBox,
      boxes: allItems[0].boxes,
    );
  }

  @override
  Future<void> removeAllPallets() async {
    final int countRowDelete =
        await _database.delete(_database.modelsPalletsTable).go();
    print(countRowDelete);
  }

  @override
  Future<void> savePallet(ModelsPallet pallet) async {
    await removeAllPallets();
    await _database.into(_database.modelsPalletsTable).insert(
          ModelsPalletsTableCompanion.insert(
            barcode: pallet.barcode,
            countItemInBox: pallet.countItemInBox,
            boxes: pallet.boxes,
          ),
        );
  }
}
