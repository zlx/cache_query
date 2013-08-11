require "cache_query/version"
require 'active_support/concern'

module CacheQuery
  extend ActiveSupport::Concern

  included do
    after_commit :flush_cache

    def flush_cache
      Rails.cache.delete "all_#{name}"
    end
  end

  module ClassMethods
    def cache_find id
      Rails.cache.fetch([name, id]) { self.find_by_id id }
    end

    def cache_all
      Rails.cache.fetch("all_#{name}") { name.constantize.all.to_a }
    end

  end

  # Your code goes here...
end
