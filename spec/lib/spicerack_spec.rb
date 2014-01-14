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
      assert_file "lib/assets/stylesheets/_reset.sass",
        "https://gist.github.com/camerond/7681450/raw/whitespace-reset.sass"
      assert_file "lib/assets/stylesheets/cask.sass",
        "https://gist.github.com/camerond/8030122/raw/cask.sass"
    end
  end

  describe 'minical' do
    it "creates coffeescript, sass and png files from remote sources" do
      assert_file 'lib/assets/javascripts/jquery.minical.js.coffee',
        'https://raw.github.com/camerond/jquery-minical/master/source/javascripts/jquery.minical.js.coffee'
      assert_file 'lib/assets/stylesheets/jquery.minical.css.sass',
        'https://raw.github.com/camerond/jquery-minical/master/source/stylesheets/jquery.minical.css.sass'
      assert_file 'lib/assets/images/jquery_minical_icons.png',
        'https://raw.github.com/camerond/jquery-minical/master/source/images/jquery_minical_icons.png'
    end
  end

  describe 'sortr' do
    it "creates coffeescript file from remote sources" do
      assert_file "lib/assets/javascripts/jquery.sortr.js.coffee",
        "https://raw.github.com/camerond/jquery-sortr/master/source/javascripts/jquery.sortr.js.coffee"
    end
  end

  describe 'stagehand' do
    it 'creates coffee, sass, and png files from remote sources' do
      assert_file "lib/assets/javascripts/stagehand.js.coffee",
        "https://raw.github.com/camerond/stagehand/master/source/javascripts/stagehand.js.coffee"
      assert_file "lib/assets/stylesheets/stagehand.sass",
        "https://raw.github.com/camerond/stagehand/master/source/stylesheets/stagehand.sass"
      assert_file "lib/assets/images/stagehand_icon.png",
        "https://raw.github.com/camerond/stagehand/master/source/images/stagehand_icon.png"
    end
  end

  describe 'supernumber' do
    it 'creates the js from remote sources' do
      assert_file 'lib/assets/javascripts/jquery.super_number.js',
        "https://raw.github.com/shaneriley/super_number/master/source/javascripts/jquery.super_number.js"
    end
  end

  describe 'ui' do
    it 'creates an index view and ui controller from templates' do
      assert_file 'app/views/ui/index.html.haml',
        File.expand_path('../../../lib/templates/index.html.haml', __FILE__)
      assert_file 'app/controllers/ui_controller.rb',
        File.expand_path('../../../lib/templates/ui_controller.rb', __FILE__)
    end
  end

end
