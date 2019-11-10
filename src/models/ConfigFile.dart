class ConfigParseInformation {
  final hosts = List<Host>();
  final latestComments = List<CommentLine>();
}

class ConfigFile {
  final hosts = List<Host>();
  final eofComments = List<CommentLine>();

  ConfigFile(List<String> lines) {
    final parseResult =
        lines.fold(ConfigParseInformation(), ConfigFile.parseFileContents);

    hosts
      ..clear()
      ..addAll(parseResult.hosts);

    eofComments.addAll(parseResult.latestComments);
  }

  static ConfigParseInformation parseFileContents(
      ConfigParseInformation info, String line) {
    if (line.trim().length == 0) {
      return info;
    }

    final commentRegExp = RegExp(r'^\s*#(.*)$');
    final optionRegExp = RegExp(r'^\s*([A-Za-z-]+)\s+(.*)$');

    final matches =
        commentRegExp.firstMatch(line) ?? optionRegExp.firstMatch(line);

    final usedPattern = (matches.pattern as RegExp).pattern;

    if (usedPattern == commentRegExp.pattern) {
      info.latestComments.add(CommentLine(matches[1]));
    } else if (usedPattern == optionRegExp.pattern) {
      if (matches[1].toLowerCase() == 'host') {
        final host = Host(matches[2], List.from(info.latestComments));
        info.hosts.add(host);
      } else {
        final option =
            HostOption(matches[1], matches[2], List.from(info.latestComments));
        info.hosts.last.options.add(option);
      }

      info.latestComments.clear();
    }

    return info;
  }
}

class Host {
  final String name;
  final List<CommentLine> comments;
  final options = List<HostOption>();

  Host(this.name, this.comments);

  toString() => '${name}\n${options.map((opt) => '  ${opt}').join('\n')}';

  HostOption getOption(String optionName) {
    return options.firstWhere(
        (option) => option.name.toLowerCase() == optionName.toLowerCase(),
        orElse: () => null);
  }
}

class HostOption {
  final String name, value;
  final List<CommentLine> comments;

  HostOption(this.name, this.value, this.comments);

  toString() =>
      '${comments.join('\n')}${comments.length > 0 ? '\n' : ''}${name}: "${value}"';
}

class CommentLine {
  final String value;

  CommentLine(String value) : value = value.trim();

  toString() => '# ${value}';
}
