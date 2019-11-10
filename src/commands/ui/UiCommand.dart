import 'package:args/command_runner.dart';
import 'package:flutter/foundation.dart'
 show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';

import '../../ui/MyApp.dart';

class UiCommand extends Command<void> {
  final name = 'ui';
  final description = 'Starts the UI';

  void run() {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;

    runApp(MyApp());
  }
}
