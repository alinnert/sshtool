class Host {
  String name;
  final options = new List<HostOption>();

  Host(this.name);

  toString() =>
      name + '\n  ' + options.map((opt) => opt.toString()).join(' | ');
}

class HostOption {
  String name, value;

  HostOption(this.name, this.value);

  toString() => name + ': ' + value;
}
