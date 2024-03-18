module SFTP
  module Shell
    def self.run(array_of_commands)
      command_str = [array_of_commands].join(" ")
      `bash  -c \"#{command_str}\"`
      return if $CHILD_STATUS.success?

      raise Error, "Error occurred during SFTP process: #{$CHILD_STATUS.exitstatus}"
    end
  end
end
