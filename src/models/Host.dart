class ConfigFile {
  final hosts = List<Host>();
  final eofComments = List<CommentLine>();

  ConfigFile(List<String> lines) {
    final hosts = lines.fold(List<Host>(), ConfigFile.parseFileContents);

    this.hosts
      ..clear()
      ..addAll(hosts);
  }

  static List<Host> parseFileContents(List<Host> hosts, String line) {
    final optionRegExp = RegExp(r'^\s*([A-Za-z-]+)\s+(.*)$');
    // final commentRegExp = RegExp(r'^\s*#(.*)$');
    final matches = optionRegExp.firstMatch(line);
    if (matches == null) return hosts;

    final optionName = matches.group(1);
    final optionValue = matches.group(2);

    if (optionName == 'Host') {
      hosts.add(Host(optionValue));
    } else {
      final host = hosts.last;
      if (host == null) return hosts;
      hosts.last.options.add(HostOption(optionName, optionValue, []));
    }

    return hosts;
  }
}

class Host {
  String name;
  final comments = List<String>();
  final options = List<HostOption>();

  Host(this.name);

  toString() => '${name}\n${options.map((opt) => '  ${opt}').join('\n')}';
}

class HostOption {
  String name, value;
  List<String> comments;

  HostOption(this.name, this.value, this.comments);

  toString() =>
      '${comments.join('\n')}${comments.length > 0 ? '\n' : ''}${name}: "${value}"';
}

class CommentLine {
  String value;

  CommentLine(this.value);

  toString() => '# ${value}';
}
