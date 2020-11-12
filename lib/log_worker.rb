# frozen_string_literal: true

# Worker for STDOUT logs
require 'logger'

class LogWorker
  $docker_stdout = IO.new(IO.sysopen("/proc/1/fd/1", "w"),"w")

  def self.log(string)
    Logger.new($docker_stdout).info(string)
  end
end
