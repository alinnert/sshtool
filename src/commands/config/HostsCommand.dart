import 'package:args/command_runner.dart';

import 'HostsListCommand.dart';

class HostsCommand extends Command<void> {
  final name = 'hosts';
  final description = 'Configure hosts in your SSH config';

  HostsCommand() {
    argParser.addFlag('global',
        abbr: 'g',
        negatable: false,
        help: [
          'Setting this flag uses the global config file.',
          'Otherwise, the one in your user directory is used.'
        ].join('\n'));

    addSubcommand(HostsListCommand());
  }

  void run() {
    print('config hosts...');
  }
}
