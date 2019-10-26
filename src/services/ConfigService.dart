import 'dart:io';

List<String> fileContent = null;

List<String> _getUserConfigFileContent(
    {bool global = false, bool force = false}) {
  final filename = _getConfigFilePath(global);
  if (fileContent == null || force) {
    final file = new File(filename);
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

List<String> _getHostsFromConfigFileContent(List<String> lines) {
  final hostLines = lines
      .where((line) => line.startsWith('Host '))
      .map((line) => line.replaceFirst('Host ', ''))
      .toList();

  return hostLines;
}

List<String> getHostNames({bool global = false}) {
  final lines = _getUserConfigFileContent(global: global, force: false);
  final hosts = _getHostsFromConfigFileContent(lines);
  return hosts;
}
