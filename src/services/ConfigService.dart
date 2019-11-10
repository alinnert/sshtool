import 'dart:io';

import '../models/ConfigFile.dart';

List<String> fileContent = null;

List<String> _getConfigFileContent({bool global = false, bool force = false}) {
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

List<String> getHostNames({bool global = false}) {
  final lines = _getConfigFileContent(global: global);
  final config = ConfigFile(lines);
  return config.hosts
      .map((host) =>
          '${host.name} (${host.getOption('hostname')?.value ?? 'none'})')
      .toList();
}

List<String> getHostInfo({bool global = false}) {
  final lines = _getConfigFileContent(global: global);
  final config = ConfigFile(lines);
  final hosts = config.hosts.map((host) {
    final hostOutput = '[ ${host.name} ]\n';

    final optionsOutput = host.options.map((option) {
      final comments =
          option.comments.map((comment) => '\n${comment}').join('');
      return '${option.name}: ${option.value}${comments}';
    }).join('\n');

    return hostOutput + optionsOutput;
  }).toList();

  return hosts + config.eofComments.map((comment) => '${comment}').toList();
}
