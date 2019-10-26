import 'dart:io';

import '../models/Host.dart';

List<String> fileContent = null;

List<String> _getConfigFileContent(
    {bool global = false, bool force = false}) {
  final filename = _getConfigFilePath(global);
  if (fileContent == null || force) {
    final file = new File(filename);
    fileContent = file.readAsLinesSync();
  }
  return fileContent;
}

List<Host> _parseConfig(List<String> lines) {
  return lines.fold(new List<Host>(), (List<Host> hosts, String line) {
    final exp = new RegExp(r'^\s*([A-Za-z-]+)\s+(.*)$');
    final matches = exp.firstMatch(line);
    if (matches == null) { return hosts; }

    final optionName = matches.group(1);
    final optionValue = matches.group(2);

    if (optionName == 'Host') {
      hosts.add(new Host(optionValue));
    } else {
      final host = hosts.last;
      if (host == null) { return hosts; }
      hosts.last.options.add(new HostOption(optionName, optionValue));
    }

    return hosts;
  });
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
  return _parseConfig(lines).map((host) => host.name).toList();
}

List<String> getHostNames({bool global = false}) {
  final lines = _getConfigFileContent(global: global, force: false);
  final config = _parseConfig(lines);
  return config.map((host) => host.toString()).toList();
}
