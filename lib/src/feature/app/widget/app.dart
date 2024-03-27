import 'package:flutter/material.dart';
import 'package:hs_conclusion/src/feature/replacement/widget/replacment_scope.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:hs_conclusion/src/feature/app/widget/material_context.dart';
import 'package:hs_conclusion/src/feature/initialization/logic/initialization_processor.dart';
import 'package:hs_conclusion/src/feature/initialization/model/dependencies.dart';
import 'package:hs_conclusion/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:hs_conclusion/src/feature/settings/widget/settings_scope.dart';

/// {@template app}
/// [App] is an entry point to the application.
///
/// Scopes that don't depend on widgets returned by [MaterialApp]
/// ([Directionality], [MediaQuery], [Localizations]) should be placed here.
/// {@endtemplate}
class App extends StatelessWidget {
  /// {@macro app}
  const App({required this.result, super.key});

  /// The initialization result from the [InitializationProcessor]
  /// which contains initialized dependencies.
  final InitializationResult result;

  @override
  Widget build(BuildContext context) => DefaultAssetBundle(
        bundle: SentryAssetBundle(),
        child: DependenciesScope(
          dependencies: result.dependencies,
          child: ReplacmentScope(
            child: SettingsScope(
              settingsBloc: result.dependencies.settingsBloc,
              child: const MaterialContext(),
            ),
          ),
        ),
      );
}
