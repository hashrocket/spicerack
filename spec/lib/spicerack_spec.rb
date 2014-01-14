require 'helpers'
require 'rake'

RSpec.configure do |c|
  c.include Helpers
end

describe 'spicerack' do

  task_path = "tasks/spicerack"

  before :all  do
    ENV["GEM_TESTING"] = 'true'
    Rake.application.rake_require(task_path)
    Rake::Task.define_task(:environment)
  end

  before :each do
    Rake.application.invoke_task "spicerack:#{subject}"
  end

  after(:all) do
    FileUtils.rm_rf('tmp')
  end

  describe 'cask' do
    it "creates sass files from remote sources" do
      assert_remote_file "lib/assets/stylesheets/_reset.sass",
        "https://gist.github.com/camerond/7681450/raw/whitespace-reset.sass"
      assert_remote_file "lib/assets/stylesheets/cask.sass",
        "https://gist.github.com/camerond/8030122/raw/cask.sass"
    end
  end

  describe 'minical' do
    it "creates coffeescript, sass and png files from remote sources" do
      assert_remote_file 'lib/assets/javascripts/jquery.minical.js.coffee',
        'https://raw.github.com/camerond/jquery-minical/master/source/javascripts/jquery.minical.js.coffee'
      assert_remote_file 'lib/assets/stylesheets/jquery.minical.css.sass',
        'https://raw.github.com/camerond/jquery-minical/master/source/stylesheets/jquery.minical.css.sass'
      assert_remote_file 'lib/assets/images/jquery_minical_icons.png',
        'https://raw.github.com/camerond/jquery-minical/master/source/images/jquery_minical_icons.png'
    end
  end

  describe 'sortr' do
    it "creates coffeescript file from remote sources" do
      assert_remote_file "lib/assets/javascripts/jquery.sortr.js.coffee",
        "https://raw.github.com/camerond/jquery-sortr/master/source/javascripts/jquery.sortr.js.coffee"
    end
  end

  describe 'stagehand' do
    it 'creates coffee, sass, and png files from remote sources' do
      assert_remote_file "lib/assets/javascripts/stagehand.js.coffee",
        "https://raw.github.com/camerond/stagehand/master/source/javascripts/stagehand.js.coffee"
      assert_remote_file "lib/assets/stylesheets/stagehand.sass",
        "https://raw.github.com/camerond/stagehand/master/source/stylesheets/stagehand.sass"
      assert_remote_file "lib/assets/images/stagehand_icon.png",
        "https://raw.github.com/camerond/stagehand/master/source/images/stagehand_icon.png"
    end
  end

end
