require 'helpers'
require 'rake'

RSpec.configure do |c|
  c.include Helpers
end

describe 'cask' do

  let(:task_path){ "tasks/spicerack" }

  before(:all) do
    ENV["TESTING"] = 'true'
    Rake.application.rake_require(task_path)
    Rake::Task.define_task(:environment)
    Rake.application.invoke_task "spicerack:cask"
  end

  it "creates sass files from remote sources" do
    assert_remote_file_contents "lib/assets/stylesheets/_reset.sass", "https://gist.github.com/camerond/7681450/raw/whitespace-reset.sass"
    assert_remote_file_contents "lib/assets/stylesheets/cask.sass", "https://gist.github.com/camerond/8030122/raw/cask.sass"
  end

  after(:all) do
    FileUtils.rm_rf('tmp')
  end

end

