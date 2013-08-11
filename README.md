# CacheQuery

Cache Every Query For Your Rails App

## Installation

Add this line to your application's Gemfile:

    gem 'cache_query'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cache_query

## Usage

### Quick start

### Models


	class Mission < ActiveRecord::Base
	  include CacheQuery
	  
	  belongs_to :creator, class_name: "User"
	  belongs_to :assigned_to, class_name: "User"
	
	  has_many :comments, :as => :commentable
	  has_many :events, :as => :eventable
	  
	  ## ...
	end


### Controller

	class MissionsController < ApplicationController
	  before_action :set_mission, except: [:index]
	
	  def 
	    @missions = Mission.cache_all
	    @events = Event.cache("newest_event", lambda { Event.order("id desc").limit(10) })
	  end
	  
	  def show; end
	
	  def edit; end
	  
	
	  private
	  def set_mission
	    @mission = Mission.cache_find params[:id]
	  end
	end


### View

	  # ...
	  span = link_to @mission.cache_creator.nickname, '#'
	  # ...
	  .comments.well
	    = render partial: "comments", locals: {comments: @mission.cache_comments, comments_count: @mission.cache_comments_count}
	  # ...

### Documents

#### cache_find

Replace `find`

	Mission.cache_find params[:id]

### cache_all

Replace `all`

	Mission.cache_all

### cache

Define custom cache on model class

	Mission.cache("awsome_cache", lambda { Mission.order("id desc").limit(10) })

### cache_#{association}

Replace `association` methods

Suppose a team has many users

	@team = Team.cache_find params[:id]
	@team.cache_users

### cache_#{association}_count

Replace `association_count` methods

Suppose a team has many users

	@team = Team.cache_find params[:id]
	@team.cache_users_count

### cache_where

	 come soon...

In a word,

+ use `cache_find` instead of `find`
+ use `cache_#{association}` instead of `association`
+ use `cache_#{association}_count` instead of `association_count`
+ use `cache_where` instead of `where`

And we will do other things for you


## Todo

- [x] Add `cache_find`
- [x] Add `cache_all`
- [x] Add `cache`
- [x] Add `cache_#{association}`
- [x] Add `cache_#{association}_count`
- [ ] Add `cache_where`
- [ ] Add Test

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
