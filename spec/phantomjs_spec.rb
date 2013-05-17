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
      result.should eq("bar foo1 foo2\n")
    end
    
    it "accepts a block that will get called for each line of output" do
      line = ''
      script = File.expand_path('./spec/runner.js')
      Phantomjs.run(script, 'foo1', 'foo2') do |l|
        line << l
      end
      line.should eq("bar foo1 foo2\n")
    end
  end
end
