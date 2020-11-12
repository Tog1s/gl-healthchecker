# frozen_string_literal: true

# Check url status

class HealthChecker
  attr_reader :response

  def rotate_urls
    if RedisWorker.urls.nil?
      LogWorker.log("URL is not present")
    else
      RedisWorker.urls.each do |u|
        response = check_url(u['url'])
        statistic = {
          server_id: u['id'], 
          url: u['url'], 
          code: response[:code], 
          delay: response[:delay]
        }
        LogWorker.log(statistic)
        RedisWorker.push_data statistic
      end
    end
  end

  def check_url(url)
    starttime = Time.now
    begin
    request = RestClient::Request.execute(
      method: :get,
      url: url,
      open_timeout: 10,
      timeout: 10
    )
    rescue => e
      e.response
    end
    endtime = Time.now
    

    delay = ((endtime - starttime) * 1000.0).round(2)
    @response = { code: request.code, delay: delay }
  end
end
