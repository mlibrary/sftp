# frozen_string_literal: true

RSpec.describe SFTP do
  it "has a version number" do
    expect(SFTP::VERSION).not_to be nil
  end

  it "responds to .client" do
    expect(SFTP.respond_to?(:client)).to eq(true)
  end
  it "responds to .configure" do
    expect(SFTP.respond_to?(:client)).to eq(true)
  end
  context "configuration" do
    it "has configs from environment variables" do
      ClimateControl.modify SFTP_USER: "sftp_user",
        SFTP_HOST: "sftp_host", SFTP_SSH_KEY_PATH: "sftp_ssh_key_path" do
        config = SFTP.configuration
        expect(config.user).to eq("sftp_user")
        expect(config.host).to eq("sftp_host")
        expect(config.key_path).to eq("sftp_ssh_key_path")
        SFTP.reset_config
      end
    end
    it "when no env-var configs are empty strings" do
      ClimateControl.modify SFTP_USER: nil,
        SFTP_HOST: nil, SFTP_SSH_KEY_PATH: nil do
        config = SFTP.configuration
        expect(config.user).to eq("")
        expect(config.host).to eq("")
        expect(config.key_path).to eq("")
        SFTP.reset_config
      end
    end
  end
end

RSpec.describe SFTP::Client do
  before(:each) do
    @user = "user"
    @host = "host"
    @key_path = "key_path"
    @shell = class_double(SFTP::Shell, run: "")

    SFTP.configure do |config|
      config.user = @user
      config.host = @host
      config.key_path = @key_path
    end
    @sftp_command_base = [
      "sftp",
      "-oIdentityFile=#{@key_path}",
      "-oStrictHostKeyChecking=no",
      "-b",
      "-",
      "#{@user}@#{@host}", "<<<"
    ]
  end
  subject do
    described_class.new(@shell)
  end
  context "#ls" do
    it "sends appropriate basic message to shell" do
      command = [@sftp_command_base, "$'@ls my/path'"].flatten
      expect(@shell).to receive(:run).with(command)
      subject.ls("my/path")
    end
  end
  context "#rename" do
    it "sends appropriate basic message to shell" do
      command = [@sftp_command_base, "$'@rename my/from/path my/to/path'"].flatten
      expect(@shell).to receive(:run).with(command)
      subject.rename("my/from/path", "my/to/path")
    end
  end
  context "#get" do
    it "sends appropriate basic message to shell" do
      command = [@sftp_command_base, "$'@get my/source/path my/destination/path'"].flatten
      expect(@shell).to receive(:run).with(command)
      subject.get("my/source/path", "my/destination/path")
    end
  end
end
