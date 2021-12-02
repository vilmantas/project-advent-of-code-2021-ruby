# Day-2
class PositionCalculator

  attr_reader :x, :y, :aim

  def initialize
    @x = 0
    @y = 0
    @aim = 0
  end

  def forward(step)
    @x += step
  end

  def down(step)
    @y += step
  end

  def up(step)
    @y -= step
  end

  def aim_up(step)
    @aim -= step
  end

  def aim_down(step)
    @aim += step
  end

  def aim_forward(step)
    @x += step
    @y += step * aim
  end
end