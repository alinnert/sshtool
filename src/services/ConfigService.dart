import 'dart:io';

class ConfigService {
  static List<String> fileContent = null;

  static _getUserConfigFileContent({bool global = false, bool force = false}) {
    final env = Platform.environment;
    final homeDir = Platform.isWindows ? env['UserProfile'] : env['HOME'];
    final filename = global ? '' : homeDir + '/.ssh/config';

    if (fileContent == null || force) {
      final file = new File(filename);
      fileContent = file.readAsLinesSync();
    }

    return fileContent;
  }

  static List<String> getHostNames({bool global = false}) {
    return _getUserConfigFileContent(global: global, force: false);
  }
}
