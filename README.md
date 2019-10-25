# SSH tool

This is going to be a small tool to manage your SSH settings.

I'm using [Dart](https://dart.dev) because I want this to be a CLI with a GUI on top later on. And I'm looking forward to [Flutter](https://flutter.dev) supporting desktop environments. Let's see how that works out.

`sshtool` is only the project name. I haven't decided on a real name, yet.

Some name ideas are:

- clam (coming from "giant clam")
- sesh (alternative abbreviation for "secure shell")
- kee (alternative spelling for "key")

## CLI Usage (draft)

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
# upload public key to a remote
# [--key] optionally specify which key to upload
# [--target-file] optionally specify where the "authorized_keys" is located
sshtool key upload [--key|-k <key-file>] [--target-file|-t <file>]

# display help
sshtool --help

# more to come...
~~~
