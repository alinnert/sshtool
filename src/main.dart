import 'dart:io';

import 'package:args/command_runner.dart';
// import 'package:console/console.dart';

import 'commands/config/HostsCommand.dart';

// import 'commands/ui/UiCommand.dart';

void main(List<String> arguments) {
  // Console.init();

  CommandRunner<void>('sshtool', 'A ssh management tool')
    ..addCommand(HostsCommand())
    // ..addCommand(UiCommand())
    ..run(arguments).catchError((dynamic error) {
      if (error is! UsageException) throw error;
      print(error);
      exit(64);
    });
}
