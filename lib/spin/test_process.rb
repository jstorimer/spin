module Spin
  class TestProcess
    attr_accessor :pid

    # Use wait(2) to block execution until the test process has finished. When
    # finished, reset the assigned pid.
    def wait
      Process.wait
      @pid = nil
    end

    # Returns +true+ if the test process is alive.
    def alive?
      !@pid.nil?
    end

    def to_s
      @pid.to_s
    end
  end
end
