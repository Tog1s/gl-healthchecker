# frozen_string_literal: true

# Fetch url from file
require 'redis'
require "json"

class FetchUrls
  def self.urls
    redis = Redis.new(
      host: "redis",
      reconnect_attempts: 8,
      reconnect_delay: 2
    )
    urls = JSON.parse(redis.get("urls"))
  end
end
