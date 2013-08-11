ENV['RAILS_ENV'] = 'test'
ENV['RAILS_ROOT'] = File.expand_path("../dummy", __FILE__)

require File.expand_path("../dummy/config/environment", __FILE__)

require 'cache_query'
