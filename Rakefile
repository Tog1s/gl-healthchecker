require 'redis'
require 'json'

DOCKER_USERNAME = 'tog1s'
DOCKER_TAG = '0.3'

desc 'Build docker image'
task :build do
 system "docker build -t #{DOCKER_USERNAME}/healthchecker:#{DOCKER_TAG} ."
end

desc 'Run redis for test'
task :runredis do
  system "docker run -p 6379:6379 --name redis -d redis"
end
