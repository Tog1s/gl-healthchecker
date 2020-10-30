# frozen_string_literal: true

# Fetch url from file
require 'redis'
require 'json'

class RedisWorker

  @redis = Redis.new(
    host: "localhost",
    reconnect_attempts: 8,
    reconnect_delay: 2
  )

  def self.urls
    urls = @redis.get("urls")
    if urls.nil?
      puts "urls is empty"
    else
      JSON.parse(urls)
    end
  end

  def self.push_data(data)
    @redis.rpush "statistics", data.to_json
  end
end
