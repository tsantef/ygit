if ENV['RAILS_ENV'] == 'production'  # don't bother on dev
  ENV['GEM_PATH'] = '/home/delta_delta/.gems'
end

# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Ygit::Application.initialize!
