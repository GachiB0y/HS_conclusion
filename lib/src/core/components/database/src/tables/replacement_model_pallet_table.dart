// ignore_for_file: prefer-declaring-const-constructor
import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:hs_conclusion/src/feature/replacement/model/pallet_model.dart';

class ModelsPalletsTable extends Table {
  TextColumn get barcode => text()();
  TextColumn get boxes => text().map(const BoxConverter())();
  IntColumn get countItemInBox => integer()();

  @override
  Set<Column> get primaryKey => {barcode};
}

class BoxConverter extends TypeConverter<List<Box>, String> {
  const BoxConverter();

  @override
  List<Box> fromSql(String fromDb) {
    if (fromDb.isEmpty) {
      return [];
    }
    final List<dynamic> jsonList = jsonDecode(fromDb) as List<dynamic>;

    final List<Box> boxes = jsonList
        .map((json) => Box.fromJson(json as Map<String, dynamic>))
        .toList();

    return boxes;
    // Implement conversion logic from String to List<Box>
  }

  @override
  String toSql(List<Box> boxes) {
    if (boxes.isEmpty) {
      return '';
    }
    final List<Map<String, dynamic>> jsonList =
        boxes.map((box) => box.toJson()).toList();
    final String jsonString = jsonEncode(jsonList);
    return jsonString;
  }
}
