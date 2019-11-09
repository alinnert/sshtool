import 'dart:io';

import 'package:args/command_runner.dart';

import 'commands/config/HostsCommand.dart';


void main(List<String> arguments) {
  new CommandRunner<void>('sshtool', 'A ssh management tool')
    ..addCommand(new HostsCommand())
    ..addCommand(new ConfigCommand())
    ..run(arguments).catchError((dynamic error) {
      if (error is! UsageException) throw error;
      print(error);
      exit(64);
    });
}
