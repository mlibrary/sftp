# Sftp

This gem wraps shell `sftp` to make working with it in ruby scripts easier

## Installation

Add this line to your application's Gemfile (niquerio todo: figure out what actually needs to be put here):

```ruby
gem 'sftp'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install sftp

## Usage

Basic configuration:
```
require 'sftp'

SFTP.configure do |config|
  config.user = "your_sftp_user"
  config.host = "your_sftp_host"
  congig.key_paty = "path/to/your/ssh/key/file"
end

client = SFTP.client
```

`SFTP.client.ls` returns an array of path names to files in the sftp user's directory directory

```
SFTP.client.ls
# returns ["file1.txt,"file2.txt","directory"]

SFTP.client.ls("directory")
#returns ["directory/file3.txt","directory/file4.txt"]
```

`SFTP.client.get(from,to)` downloads the file from the `from` path on the sftp server to the `to` path on the local machine

```
SFTP.client.get("direcotry/file3.txt","./")
ls .
"file3.txt"
```

`SFTP.client.rename(from, to)` renames a file on the sftp server.
```
SFTP.client.ls
# returns ["file1.txt,"file2.txt","directory"]
SFTP.client.rename("file1.txt,"directory/renamed.txt")
SFT.client.ls
# returns ["file2.txt","directory"]
SFTP.client.ls("directory")
#returns ["directory/file3.txt","directory/file4.txt", "directory/renamed.txt"]
```

## Development

#niquerio todo

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mlibraray/sftp
