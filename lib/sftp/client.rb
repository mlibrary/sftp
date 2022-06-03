module SFTP
  class Client
    def initialize(shell = SFTP::Shell)
      @user = SFTP.configuration.user
      @host = SFTP.configuration.host
      @key_path = SFTP.configuration.key_path
      @shell = shell
    end

    # returns an array of items in a directory
    def ls(path = "")
      run_an_sftp_command("$'@ls #{path}'").split("\n").map { |x| x.strip }
    end

    def get(path, destination)
      run_an_sftp_command("$'@get #{path} #{destination}'")
    end

    def rename(from, to)
      run_an_sftp_command("$'@rename #{from} #{to}'")
    end

    private

    def run_an_sftp_command(command)
      base = ["sftp", "-oIdentityFile=#{@key_path}", "-oStrictHostKeyChecking=no", "-b", "-", "#{@user}@#{@host}", "<<<"]
      base.push(command)
      @shell.run(base)
    end
  end
end
