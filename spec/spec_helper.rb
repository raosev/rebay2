$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rebay2'

Dir["./spec/support/**/*.rb"].sort.each {|f| require f}

RSpec.configure do |config|
  config.mock_with :rspec do |mocks|
    mocks.syntax = :should
  end
end

Rebay2::Api.configure do |rebay|
  rebay.app_id = 'default'
end
