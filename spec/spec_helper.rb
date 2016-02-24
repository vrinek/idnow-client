$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'bundler/setup'
if ENV['COV']
  require 'simplecov'
  SimpleCov.start
end

require 'idnow'
require 'rspec'

require 'factory_girl'
require 'webmock/rspec'
require 'pry'
require 'shoulda/matchers'

Dir[File.join('.', 'spec', 'factories', '*.rb')].each { |file| require file }

WebMock.disable_net_connect!(allow_localhost: true, allow: 'codeclimate.com')

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
  end
end
