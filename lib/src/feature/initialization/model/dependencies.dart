import 'package:hs_conclusion/src/core/components/rest_client/rest_client.dart';
import 'package:hs_conclusion/src/feature/conclusion/data/conclusion_repository.dart';
import 'package:hs_conclusion/src/feature/replacement/data/replacement_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hs_conclusion/src/feature/settings/bloc/settings_bloc.dart';

/// {@template dependencies}
/// Dependencies container
/// {@endtemplate}
base class Dependencies {
  /// {@macro dependencies}
  const Dependencies({
    required this.sharedPreferences,
    required this.settingsBloc,
    required this.conclusionRepository,
    required this.replacementRepository,
    required this.restClient,
  });

  /// [SharedPreferences] instance, used to store Key-Value pairs.
  final SharedPreferences sharedPreferences;

  /// [SettingsBloc] instance, used to manage theme and locale.
  final SettingsBloc settingsBloc;

  /// [ConclusionBarcodeRepository] instance, used to repository barcode.
  final IConclusionBarcodeRepository conclusionRepository;

  /// [ReplacementRepository] instance, used to repository barcode.
  final IReplacementRepository replacementRepository;

  /// [RestClient] instance, used to repository barcode.
  final RestClient restClient;
}

/// {@template initialization_result}
/// Result of initialization
/// {@endtemplate}
final class InitializationResult {
  /// {@macro initialization_result}
  const InitializationResult({
    required this.dependencies,
    required this.msSpent,
  });

  /// The dependencies
  final Dependencies dependencies;

  /// The number of milliseconds spent
  final int msSpent;

  @override
  String toString() => '$InitializationResult('
      'dependencies: $dependencies, '
      'msSpent: $msSpent'
      ')';
}
