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
    unless example.metadata[:skip_before]
      Rake.application.invoke_task "spicerack:#{subject}"
    end
  end

  after(:each) do
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

  describe 'ui', skip_before: true do

    before :each do
      File.stub(:open).and_call_original
      File.stub(:open).with('config/routes.rb', 'r').and_return(content)
      File.stub(:open).with('config/routes.rb', 'w').and_yield(file)
      Rake::Task["spicerack:ui"].reenable
    end

    context 'ignore adding ui route' do
      let(:content) { double('content', include?: true) }
      let(:file) { double('file') }
      it 'creates an index view and ui controller from templates' do
        Rake.application.invoke_task "spicerack:ui"
        assert_file 'app/views/ui/index.html.haml',
          'https://raw.github.com/hashrocket/spices/master/ui/templates/index.html.haml'
        assert_file 'app/controllers/ui_controller.rb',
          'https://raw.github.com/hashrocket/spices/master/ui/templates/ui_controller.rb'
      end
    end

    describe 'ui route exists' do
      let(:content) { double('content', include?: true) }
      let(:file) { double('file') }
      it 'does not add ui route' do
        file.should_not_receive(:write)
        Rake.application.invoke_task "spicerack:ui"
      end
    end

    describe 'ui route does not exists' do
      let(:content) { double('content', include?: false, sub: nil) }
      let(:file) { double('file') }
      it 'adds a ui route' do
        file.should_receive(:write)
        Rake.application.invoke_task "spicerack:ui"
      end
    end

  end

  describe 'spicerack', skip_before: true do

    it 'prints out a list of spices' do
      puts_called = false
      STDOUT.stub(:puts) { puts_called = true }
      Rake.application.invoke_task "spicerack"
      puts_called.should be_true
    end

  end

  describe 'overwriting files', skip_before: true do

    before :each do
      Rake::Task["spicerack:cask"].reenable
    end

    it "won't overwrite a file if the user chooses not to" do
      Spice.any_instance.stub(:new_or_overwrite?).and_return(false)
      Spice.any_instance.should_not_receive(:write)
      Rake.application.invoke_task "spicerack:cask"
    end

    it 'overwrites a file if the user chooses to' do
      Spice.any_instance.stub(:new_or_overwrite?).and_return(true)
      write_called = false
      Spice.any_instance.stub(:write) { write_called = true }
      Rake.application.invoke_task "spicerack:cask"
      write_called.should be_true
    end

  end

  describe 'already existing files', skip_before: true do

    before :each do
      Rake::Task["spicerack:cask"].reenable
    end

    it "won't write a file if same file already exists" do
      Spice.any_instance.stub(:same_file_exists?).and_return(true)
      Spice.any_instance.should_not_receive(:new_or_overwrite?)
      Rake.application.invoke_task "spicerack:cask"
    end

    it "writes a file if the same file doesn't exist" do
      Spice.any_instance.stub(:same_file_exists?).and_return(false)
      write_called = false
      Spice.any_instance.stub(:new_or_overwrite?) { write_called = true }
      Rake.application.invoke_task "spicerack:cask"
      write_called.should be_true
    end

  end

end
