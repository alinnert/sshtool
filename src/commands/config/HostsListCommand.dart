import 'package:args/command_runner.dart';

import '../../services/ConfigService.dart' show getHostNames;
import '../../services/ConfigService.dart';

class HostsListCommand extends Command<void> {
  final name = 'list';
  final description = 'List all available hosts';

  HostsListCommand() {
    argParser.addFlag('verbose',
        abbr: 'v',
        negatable: false,
        help: ['Shows all settings for every host'].join('\n'));
  }

  void run() {
    final verbose = argResults['verbose'] as bool;
    final hostnames = verbose ? getHostInfo() : getHostNames();
    print(hostnames.join(verbose ? '\n\n' : '\n'));
  }
}
