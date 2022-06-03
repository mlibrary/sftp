# frozen_string_literal: true

require_relative "sftp/version"
require_relative "sftp/configuration"
require_relative "sftp/shell"
require_relative "sftp/client"

module SFTP
  class Error < StandardError; end
  # Your code goes here...
  class << self
    def client
      Client.new
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def reset_config
      remove_instance_variable(:@configuration)
    end

    def configure
      yield(configuration)
    end
  end
end
