# SFTP

This gem wraps shell `sftp` to make working with it in Ruby scripts easier.

## Installation

Add this line to your application's `Gemfile`:

```ruby
gem "sftp",
  git: "https://github.com/mlibrary/sftp",
  tag: "{latest_tag_goes_here}"
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install sftp

## Usage

Basic configuration:
```
require "sftp"

SFTP.configure do |config|
  config.user = "your_sftp_user"
  config.host = "your_sftp_host"
  config.key_path = "path/to/your/ssh/key/file"
end

client = SFTP.client
```

`SFTP.client.ls` returns an array of path names to files in the SFTP user's directory.

```
SFTP.client.ls
# returns ["file1.txt,"file2.txt","directory"]

SFTP.client.ls("directory")
#returns ["directory/file3.txt","directory/file4.txt"]
```

`SFTP.client.get(path, destination)` downloads the file from `path` on the SFTP server to the `destination` path on the local machine.

```sh
SFTP.client.get("direcotry/file3.txt", "./")
ls .
"file3.txt"
```

`SFTP.client.get_r(path, destination)` downloads everything (files and/or directories) found at `path` on the SFTP server to the `destination` path on the local machine.
```sh
SFTP.client.ls("directory")
# returns ["file1.txt", "file2.txt"]
SFTP.client.get_r("directory", "./")
ls .
# directory
ls directory
# file1.txt   file2.txt
```

`SFTP.client.rename(from, to)` renames a file on the SFTP server.

```sh
SFTP.client.ls
# returns ["file1.txt, "file2.txt", "directory"]
SFTP.client.rename("file1.txt, "directory/renamed.txt")
SFT.client.ls
# returns ["file2.txt", "directory"]
SFTP.client.ls("directory")
# returns ["directory/file3.txt", "directory/file4.txt", "directory/renamed.txt"]
```

`SFTP.client.put(path, destination)` sends a file from `path` on the local machine to the `destination` path on the SFTP server.

```sh
ls .
# "file1.txt"
SFTP.client.put("file.txt", "directory")
SFTP.client.ls("directory")
# returns ["file1.txt"]
```

If a failure occurs when an underlying `sftp` command is run, an `SFTP::Error` will be raised.

## Development

Clone the repo

```bash
git clone git@github.com:mlibrary/sftp.git
cd sftp
```

run the `init.sh` script. This will copy a pre-commit hook for git, build the
container, and set up ssh keys for development. 
```bash
./init.sh
```
start containers

```bash
docker compose up -d
```

The compose.yml has a fileserver service running sftp. The files are in the
`server/files` directory. 

To try out the gem you can run:
```bash
docker compose run --rm app console
SFTP.client.ls
```

This will load the gem in irb, and connect you to the sftp service in compose.yml

### Troubleshooting
If the the `app` service can't connect to the `sftp` service, try restarting by
doing:
```bash
docker compose down
docker compose up -d
```

The ssh keys volume mounted in may not have been properly copied to
`authorized_keys` in the `fileserver` service, and doing this hard restart will
get the appropriate ones copied in. 

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/mlibraray/sftp
