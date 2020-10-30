# frozen_string_literal: true

# Check url status
require 'logger'

class HealthChecker
  attr_reader :response
  $docker_stdout = IO.new(IO.sysopen("/proc/1/fd/1", "w"),"w")

  def log(string)
    Logger.new($docker_stdout).info(string)
  end

  def rotate_urls
    if RedisWorker.urls.nil?
      puts "URL is not present"
    else
      RedisWorker.urls.each do |u|
        response = check_url(u['url'])
        statistic = {
          server_id: u['id'], 
          url: u['url'], 
          code: response[:code], 
          delay: response[:delay]
        }
        log(statistic)
        RedisWorker.push_data statistic
      end
    end
  end

  def check_url(url)
    starttime = Time.now
    request = RestClient::Request.execute(
      method: :get,
      url: url,
      open_timeout: 10,
      timeout: 10
    )
    endtime = Time.now

    delay = ((endtime - starttime) * 1000.0).round(2)
    @response = { code: request.code, delay: delay }
  end
end
