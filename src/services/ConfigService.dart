import 'dart:io';

import '../models/Host.dart';

List<String> fileContent = null;

List<String> _getConfigFileContent(
    {bool global = false, bool force = false}) {
  final filename = _getConfigFilePath(global);
  if (fileContent == null || force) {
    final file = File(filename);
    fileContent = file.readAsLinesSync();
  }
  return fileContent;
}

String _getConfigFilePath(bool global) {
  final env = Platform.environment;
  final homeDir = Platform.isWindows ? env['UserProfile'] : env['HOME'];

  if (global) {
    if (Platform.isWindows) {
      // This gets tricky...
      // The config file is bundled with OpenSSH.
      // Its location can by anywhere:
      // - Whereever the user installs Git
      // - The OpenSSH that comes with Windows'
      // Plus: multiple versions could co-exist.
      // Have fun, future me. Greetings from the past. _o/
      // But maybe this also affects other OSes.
      throw Exception('not yet implemented');
    } else {
      return '/etc/ssh/ssh_config';
    }
  }

  return homeDir + '/.ssh/config';
}

List<String> _getHostsFromConfig(List<String> lines) {
  return ConfigFile(lines).hosts.map((host) => host.name).toList();
}

List<String> getHostNames({bool global = false}) {
  final lines = _getConfigFileContent(global: global, force: false);
  final config = ConfigFile(lines);
  return config.hosts.map((host) => host.toString()).toList();
}
