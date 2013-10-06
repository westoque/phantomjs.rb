require 'tempfile'
require "phantomjs/version"
require 'phantomjs/errors'

class Phantomjs
  EXEC = 'phantomjs'

  def self.run(path, *args)
    epath = File.expand_path(path)
    raise NoSuchPathError.new(epath) unless File.exist?(epath)
    block = block_given? ? Proc.new : nil
    execute(epath, args, block)
  end

  def self.inline(script, *args)
    file = Tempfile.new('script.js')
    file.write(script)
    file.close
    block = block_given? ? Proc.new : nil
    execute(file.path, args, block)
  end

  private

  def self.execute(path, arguments, block)
    begin
      if block
        IO.popen([EXEC, path, arguments].flatten).each_line do |line|
          block.call(line)
        end
      else
        IO.popen([EXEC, path, arguments].flatten).read
      end
    rescue Errno::ENOENT
      raise CommandNotFoundError.new('Phantomjs is not installed')
    end
  end
end
