import 'package:args/command_runner.dart';

import '../../services/ConfigService.dart' show getHostNames;

class ConfigHostsListCommand extends Command<void> {
  final name = 'list';
  final description = 'List all available hosts';

  void run() {
    final hostnames = getHostNames();
    print(hostnames.join('\n'));
  }
}
