# Sftp

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
  congig.key_paty = "path/to/your/ssh/key/file"
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

## Development

In the application root folder, set up the ssh_keys:
```
./bin/set_up_development_ssh_keys.sh
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mlibrary/sftp
