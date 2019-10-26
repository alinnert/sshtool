import 'package:args/command_runner.dart';

import '../../services/ConfigService.dart';

class ConfigHostsListCommand extends Command<void> {
  final name = 'list';
  final description = 'List all available hosts';

  void run() {
    final hostnames = ConfigService.getHostNames();
    print(hostnames.join('\n'));
  }
}
