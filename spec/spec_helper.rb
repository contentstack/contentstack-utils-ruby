require 'simplecov'
SimpleCov.add_filter ["spec/", "lib/contentstack_utils/support"]
SimpleCov.start
require 'nokogiri'
require 'rspec'
require 'contentstack_utils'
require_relative './mock/custom_render_option'
Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each { |f| require f }
Dir[File.dirname(__FILE__) + '/mock/**/*.rb'].each { |f| require f }
