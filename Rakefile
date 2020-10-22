DOCKER_USERNAME = 'tog1s'
DOCKER_TAG = '0.2'

desc 'Build docker image'
task :build do
 system "docker build -t #{DOCKER_USERNAME}/healthchecker:#{DOCKER_TAG} ."
end