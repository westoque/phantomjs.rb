require "phantomjs/version"

module Phantomjs
  # Fight the power
  extend self

  # Public: Runs the phantomjs binary
  #
  # script - The absolute path to the script
  # *args  - The arguments to pass to the script
  #
  # Returns the stdout output of phantomjs
  def run(script, *args)
    string_args = args.join(" ")
    @executable ||= get_executable

    if block_given?
      IO.popen("#{@executable} #{script} #{string_args}").each_line do |line|
        yield line
      end
    else
      `#{@executable} #{script} #{string_args}`
    end
  end

  private

  def get_executable
    if Os.is_mac?
      require 'phantomjs-mac'
    elsif Os.is_linux?
      require 'phantomjs-linux'
    else
      # Sorry windows guy
      # Nothing here
    end

    Phantomjs.executable_path
  end
end

module Os
  # Again, Fight the power
  extend self

  # universal-darwin9.0 shows up for RUBY_PLATFORM on os X leopard with the bundled ruby.
  # Installing ruby in different manners may give a different result, so beware.
  # Examine the ruby platform yourself. If you see other values please comment
  # in the snippet on dzone and I will add them.

  def is_mac?
    RUBY_PLATFORM.downcase.include?("darwin") or RbConfig::CONFIG['host_os'].include?("darwin")
  end

  def is_windows?
    RUBY_PLATFORM.downcase.include?("mswin") or RbConfig::CONFIG['host_os'].include?("mswin")
  end

  def is_linux?
    RUBY_PLATFORM.downcase.include?("linux") or RbConfig::CONFIG['host_os'].include?("linux")
  end
end
