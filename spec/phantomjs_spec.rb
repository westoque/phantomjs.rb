require 'spec_helper'

describe Phantomjs do
  describe ".run" do
    describe 'when phantomjs is non installed' do
      before { Phantomjs.configure { |config| config.phantomjs_path = 'not_existing_phantomjs' } }
      after { Phantomjs.configure { |config| config.phantomjs_path = 'phantomjs' } }

      it "raises an error" do
        script = File.expand_path('./spec/runner.js')
        expect {
          Phantomjs.run(script, 'foo1', 'foo2')
        }.to raise_error(Phantomjs::CommandNotFoundError)
      end
    end

    it 'raises an error when the script does not exist' do
      script = File.expand_path('./doesnt_exist.js')
      expect {
        Phantomjs.run(script)
      }.to raise_error(Phantomjs::NoSuchPathError)
    end

    it "runs phantomjs binary with the correct arguments" do
      script = File.expand_path('./spec/runner.js')
      result = Phantomjs.run(script, 'foo1', 'foo2')
      expect(result).to eq("bar\nfoo1\nfoo2\n")
    end

    it "accepts a block that will get called for each line of output" do
      line = ''
      script = File.expand_path('./spec/runner.js')
      Phantomjs.run(script, 'foo1', 'foo2') do |l|
        line << l
      end
      expect(line).to eq("bar\nfoo1\nfoo2\n")
    end

    it "accepts empty parameters" do
      line = ''
      script = File.expand_path('./spec/runner.js')
      Phantomjs.run(script, 'foo1', 'foo2', '') do |l|
        line << l
      end
      expect(line).to eq("bar\nfoo1\nfoo2\n\n")
    end

    it "accepts parameters with spaces" do
      line = ''
      script = File.expand_path('./spec/runner.js')
      Phantomjs.run(script, 'foo bar', 'foo2') do |l|
        line << l
      end
      expect(line).to eq("bar\nfoo bar\nfoo2\n")
    end

    it "accepts empty parameters without block" do
      script = File.expand_path('./spec/runner.js')
      output = Phantomjs.run(script, 'foo1', 'foo2', '')
      expect(output).to eq("bar\nfoo1\nfoo2\n\n")
    end

    it "accepts parameters with spaces without block" do
      script = File.expand_path('./spec/runner.js')
      output = Phantomjs.run(script, 'foo bar', 'foo2')
      expect(output).to eq("bar\nfoo bar\nfoo2\n")
    end
  end

  describe '.inline' do
    it 'accepts and runs a script as an argument' do
      js = %q(
        console.log(phantom.args[0]);
        phantom.exit();
      )
      result = Phantomjs.inline(js, 'works!')
      expect(result).to eq("works!\n")
    end

    it 'accepts a block as an argument' do
      js = %q(
        ctr = 0;
        setInterval(function() {
          if (ctr == 3) {
            phantom.exit();
          }
          console.log('ctr is ' + ctr);
          ctr++;
        }, 1000)
        console.log('running interval')
      )
      expected = "running interval\nctr is 0\nctr is 1\nctr is 2\n"
      str = '';
      Phantomjs.inline(js) do |line|
        str << line
      end
      expect(str).to match(expected)
    end
  end
end
