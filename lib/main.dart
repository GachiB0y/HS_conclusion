import 'dart:async';

import 'package:hs_conclusion/src/core/utils/logger.dart';
import 'package:hs_conclusion/src/feature/app/logic/app_runner.dart';

void main() {
  logger.runLogging(
    () => runZonedGuarded(
      () => const AppRunner().initializeAndRun(),
      logger.logZoneError,
    ),
    const LogOptions(),
  );
}
