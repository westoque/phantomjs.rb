require "tempfile"
require "phantomjs/configuration"
require "phantomjs/version"
require "phantomjs/errors"

class Phantomjs

  def self.run(path, *args, &block)
    Phantomjs.new.run(path, *args, &block)
  end

  def run(path, *args)
    epath = File.expand_path(path)
    raise NoSuchPathError.new(epath) unless File.exist?(epath)
    block = block_given? ? Proc.new : nil
    execute(epath, args, block)
  end

  def self.inline(script, *args, &block)
    Phantomjs.new.inline(script, *args, &block)
  end

  def inline(script, *args)
    file = Tempfile.new('script.js')
    file.write(script)
    file.close
    block = block_given? ? Proc.new : nil
    execute(file.path, args, block)
  end

  def self.configure(&block)
    Configuration.configure(&block)
  end

  private

  def execute(path, arguments, block)
    begin
      if block
        IO.popen([exec, path, arguments].flatten).each_line do |line|
          block.call(line)
        end
      else
        IO.popen([exec, path, arguments].flatten).read
      end
    rescue Errno::ENOENT
      raise CommandNotFoundError.new('Phantomjs is not installed')
    end
  end

  def exec
    Phantomjs::Configuration.phantomjs_path
  end
end
