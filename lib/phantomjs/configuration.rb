class Phantomjs
  module Configuration
    extend self

    attr_accessor :phantomjs_path

    Phantomjs::Configuration.phantomjs_path ||= 'phantomjs'

    def configure
      yield self
    end

  end
end
