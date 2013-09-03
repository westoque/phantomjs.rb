require 'phantomjs'

describe Phantomjs do
  describe ".run" do
    describe 'when phantomjs is non installed' do
      before { Phantomjs::EXEC = 'not_existing_phantomjs' }
      after  { Phantomjs::EXEC = 'phantomjs' }

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
      result.should eq("bar\nfoo1\nfoo2\n")
    end
    
    it "accepts a block that will get called for each line of output" do
      line = ''
      script = File.expand_path('./spec/runner.js')
      Phantomjs.run(script, 'foo1', 'foo2') do |l|
        line << l
      end
      line.should eq("bar\nfoo1\nfoo2\n")
    end

    it "accepts empty parameters" do
      line = ''
      script = File.expand_path('./spec/runner.js')
      Phantomjs.run(script, 'foo1', 'foo2', '') do |l|
        line << l
      end
      line.should eq("bar\nfoo1\nfoo2\n\n")
    end

    it "accepts parameters with spaces" do
      line = ''
      script = File.expand_path('./spec/runner.js')
      Phantomjs.run(script, 'foo bar', 'foo2') do |l|
        line << l
      end
      line.should eq("bar\nfoo bar\nfoo2\n")
    end
  end
end
