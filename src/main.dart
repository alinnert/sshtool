import 'dart:io';

import 'package:args/command_runner.dart';

import 'commands/config/configCommand.dart';

void main(List<String> arguments) {
  new CommandRunner("sshtool", "A ssh management tool")
    ..addCommand(new ConfigCommand())
    ..run(arguments).catchError((error) {
      if (error is! UsageException) throw error;
      print(error);
      exit(64);
    });
}
