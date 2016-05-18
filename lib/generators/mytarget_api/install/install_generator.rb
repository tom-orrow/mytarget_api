# A rails generator `mytarget_api:install`.
# It creates a config file in `config/initializers/mytarget_api.rb`.
class MytargetApi::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  # Creates the config file.
  def create_initializer
    copy_file 'initializer.rb', 'config/initializers/mytarget_api.rb'
  end
end
