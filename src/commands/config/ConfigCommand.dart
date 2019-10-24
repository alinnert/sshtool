import 'package:args/command_runner.dart';

import 'ConfigHostsCommand.dart';

class ConfigCommand extends Command {
  final name = 'config';
  final description = 'View or change config settings';

  ConfigCommand() {
    argParser.addFlag('global', abbr: 'g');
    addSubcommand(new ConfigHostsCommand());
  }

  void run() {
    if (argResults['global']) {
      print('global config...');
    } else {
      print('user config...');
    }
  }
}
