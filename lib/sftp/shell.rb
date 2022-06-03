module SFTP
  module Shell
    def self.run(array_of_commands)
      command_str = [array_of_commands].join(" ")
      `bash  -c \"#{command_str}\"`
    end
  end
end
