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
    `#{@executable} #{script} #{string_args}`
  end

  private

  def get_executable
    if Os.is_mac?
      File.expand_path("./vendor/phantomjs-1.4.1_OSX/bin/phantomjs")
    elsif Os.is_linux?
      File.expand_path("./vendor/phantomjs-1.5.0-liunx-x86-dynamic/bin/phantomjs")
    else
      # Sorry windows guy
      # Nothing here
    end
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
    RUBY_PLATFORM.downcase.include?("darwin")
  end

  def is_windows?
    RUBY_PLATFORM.downcase.include?("mswin")
  end

  def is_linux?
    RUBY_PLATFORM.downcase.include?("linux")
  end
end
