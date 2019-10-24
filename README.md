# SSH tool

This is going to be a small tool to manage your SSH settings.

I'm using [Dart](https://dart.dev) because I want this to be a CLI with a GUI on top later on. And I'm look forward to [Flutter](https://flutter.dev) supporting desktop environments.

## Usage (draft)

~~~ bash
# list all hosts
sshtool config [--global|-g] hosts ls
sshtool config [--global|-g] hosts list
# add host interactively
sshtool config [--global|-g] hosts add
# add host directly
sshtool config [--global|-g] hosts add <host-name> --host <host-addr>
# remove host
sshtool config [--global|-g] host remove <host-name>

# generate key pair
sshtool key generate
# copy public key to clipboard
sshtool key copy
# change key passphrase
sshtool key change-passphrase

# display help
sshtool --help

# more to come...
~~~
