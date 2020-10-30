# frozen_string_literal: true

require 'rest-client'
require_relative 'lib/redis_worker'
require_relative 'lib/health_checker'

health_checker = HealthChecker.new

loop do
  health_checker.rotate_urls
  sleep 60
end
