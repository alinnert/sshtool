import 'package:args/command_runner.dart';

import 'ConfigHostsListCommand.dart';

class ConfigHostsCommand extends Command {
  final name = 'hosts';
  final description = 'Configure hosts in your SSH config';

  ConfigHostsCommand() {
    addSubcommand(new ConfigHostsListCommand());
  }

  void run() {
    print('config hosts...');
  }
}
