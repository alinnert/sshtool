# SSH tool

This is going to be a small tool to manage your SSH settings.

I'm using [Dart](https://dart.dev) because I want this to be a CLI with a GUI on top later on. And I'm looking forward to [Flutter](https://flutter.dev) supporting desktop environments. Let's see how that works out.

`sshtool` is only the project name. I haven't decided on a real name, yet.

Some name ideas are:

- clam (coming from "giant clam")
- sesh (alternative abbreviation for "secure shell")
- kee (alternative spelling for "key")

## CLI Usage (draft)

### Basic commands

~~~ bash
# run the GUI version (if available)
sshtool

# display help
sshtool --help
~~~

### Manage hosts

~~~ bash
# list all hosts
sshtool [--global|-g] hosts ls
sshtool [--global|-g] hosts list

# add host interactively
sshtool [--global|-g] hosts add

# add host directly
sshtool [--global|-g] hosts add <host-name> --host <host-addr>

# remove host
sshtool [--global|-g] host remove <host-name>
~~~

By default, the config file in your user directory is being used.

Use the `--global` flag to use the global config file.

### Manage SSH key pairs

~~~ bash
# generate key pair
sshtool key generate

# copy public key to clipboard
sshtool key copy

# change key passphrase
sshtool key change-passphrase

# upload public key to a remote
#
# --key            Optionally specify which key to upload
#
# --target-file    Optionally specify where the
#                  "authorized_keys" file is located.
sshtool key upload <remote-name> [--key|-k <key-file>] [--target-file|-t <file>]
~~~
