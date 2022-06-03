module SFTP
  class Configuration
    attr_accessor :user, :host, :key_path
    def initialize
      @user = ENV.fetch("SFTP_USER", "")
      @host = ENV.fetch("SFTP_HOST", "")
      @key_path = ENV.fetch("SFTP_SSH_KEY_PATH", "")
    end
  end
end
