
module Pomo
  class Break < Task

    def write_pomo_stat(time)
      time > 0 ? super("*#{time}") : super(time)
    end

  end
end
