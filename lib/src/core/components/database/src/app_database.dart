import 'package:drift/drift.dart';
import 'package:hs_conclusion/src/core/components/database/database.dart';
import 'package:hs_conclusion/src/core/components/database/src/tables/replacement_model_pallet_table.dart';
import 'package:hs_conclusion/src/feature/replacement/model/pallet_model.dart';

part 'app_database.g.dart';

/// {@template app_database}
/// The drift-managed database configuration
/// {@endtemplate}
@DriftDatabase(tables: [ModelsPalletsTable])
class AppDatabase extends _$AppDatabase {
  /// {@macro app_database}
  AppDatabase([QueryExecutor? executor]) : super(executor ?? createExecutor());

  @override
  int get schemaVersion => 1;
}
