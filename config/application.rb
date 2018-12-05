require_relative 'boot'

require 'rails/all'
require 'resque'
# send errors which occur in background jobs to redis and airbrake
require 'resque/failure/multiple'
require 'resque/failure/redis'

Resque::Failure::Multiple.classes = [Resque::Failure::Redis]
Resque::Failure.backend = Resque::Failure::Multiple
require 'pry'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SampleApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Include the authenticity token in remote forms.
    config.action_view.embed_authenticity_token_in_remote_forms = true

  end
end

ActiveRecord::SessionStore::Session.table_name = 'sessions'
ActiveRecord::SessionStore::Session.primary_key = 'session_id'
ActiveRecord::SessionStore::Session.data_column_name = 'data'
ActiveRecord::SessionStore::Session.serializer = :json

