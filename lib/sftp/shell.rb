module SFTP
  module Shell
    def self.run(array_of_commands)
      command_str = [array_of_commands].join(" ")
      output = `bash  -c \"#{command_str}\"`
      unless $CHILD_STATUS.success?
        raise Error, "Error occurred during SFTP process: #{$CHILD_STATUS.exitstatus}"
      end
      output
    end
  end
end
