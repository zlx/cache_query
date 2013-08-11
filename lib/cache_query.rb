require "cache_query/version"
require 'active_support/concern'
require 'set'

module CacheQuery
  extend ActiveSupport::Concern

  included do
    cattr_accessor :class_cache_keys
    after_commit :flush_cache

    def flush_cache
      Rails.cache.delete "all_#{name}"
      self.class_cache_keys.each{ |cache_key| Rails.cache.delete cache_key }
    end
  end

  def cache_where
    # place holder
  end

  def method_missing(name, *args, &block)
    # you need add touch for association record to flush the cache
    if name.to_s =~ /cache_((.*)_count)/ && self.respond_to?($2)
      Rails.cache.fetch([self, $1]) do
        self.__send__($2).__send__(:count)
      end
    elsif name.to_s =~ /cache_(.*)/ && self.respond_to?($1)
      Rails.cache.fetch([self, $1]) do
        query_result = self.__send__($1)
        if query_result.is_a?(ActiveRecord::Relation)
          query_result.to_a
        else
          query_result
        end
      end
    else
      super
    end
  end

  module ClassMethods
    def cache_find id
      Rails.cache.fetch([name, id]) { self.find_by_id id }
    end

    def cache_all
      Rails.cache.fetch("all_#{name}") { name.constantize.all.to_a }
    end

    def cache cache_name, &block
      if block_given?
        self.class_cache_keys ||= Set.new
        self.class_cache_keys.add(cache_name)
        Rails.cache.fetch(cache_name) { yield }
      end
    end
  end

  # Your code goes here...
end
