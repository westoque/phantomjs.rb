require "phantomjs/version"
require 'phantomjs/errors'

class Phantomjs
  EXEC = 'phantomjs'

  # Public: Runs the phantomjs binary
  #
  # script - The absolute path to the script
  # *args  - The arguments to pass to the script
  #
  # Returns the stdout output of phantomjs
  def self.run(script, *args)
    epath = File.expand_path(script)

    raise NoSuchPathError.new(epath) unless File.exist?(epath)

    string_args = args.join(" ")

    begin
      if block_given?
        # IO.popen("#{EXEC} #{script} #{string_args}").each_line do |line|
        IO.popen([EXEC, script, args].flatten).each_line do |line|
          yield line
        end
      else
        `#{EXEC} #{script} #{string_args}`
      end
    rescue Errno::ENOENT
      raise CommandNotFoundError.new('Phantomjs is not installed')
    end
  end
end
