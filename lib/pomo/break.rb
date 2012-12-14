
module Pomo
  class Break < Task

    private

    def tmux_time(time)
      case time
      when 0
        "#{time}:00"
      else
        "#[default]#[fg=blue]#{time}:00#[default]"
      end
    end

  end
end
