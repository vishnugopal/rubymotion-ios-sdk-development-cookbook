$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'recipes'
  app.files_dependencies 'app/app_delegate.rb' => 'app/storyboard_delegate.rb'
end