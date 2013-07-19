module Spin
  class TestProcess
    attr_accessor :pid

    # Use wait(2) to block execution until the test process has finished. When
    # finished, reset the assigned pid.
    def wait
      Process.wait
      reset_pid
    end

    # Returns +true+ if the test process is alive. If it's not, +false+ is
    # returned and the assigned pid is reset.
    def alive?
      return if @pid.nil?

      alive = Process.kill(0, @pid) rescue nil

      if (alive == 1)
        true
      else
        reset_pid
        false
      end
    end

    def to_s
      @pid.to_s
    end

  private

    # Resets the assigned pid.
    def reset_pid
      @pid = nil
    end
  end
end
