require 'spec_helper'

ENV['RAILS_ENV'] = 'test'

require_relative "ruby_react_app"

require "billy/capybara/rspec/ruby"
require "capybara/rspec"
require "capybara/dsl"
require "pry"

Dir[Dir.pwd + "/spec/support/**/*.rb"].each { |file| require file }

Billy.configure do |config|
  config.cache = true
  config.cache_path = 'spec/fixtures/features' # remove to get fresh mocks
  config.cache_request_body_methods = ['post', 'get', 'put']
  config.ignore_params = []
  config.logger = nil # comment to see logs
  config.non_successful_cache_disabled = false
  config.non_successful_error_level = :warn
  config.non_whitelisted_requests_disabled = false
  config.persist_cache = true
end

Capybara.configure do |config|
  config.default_driver = :selenium_chrome_billy
  config.app = Sinatra::Application.new
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
