class Entity
  class << self
    attr_accessor :x, :y
  end
  def initialize window, x, y, w, h
    @@x = x;
    @@y = y;
  end

  def update
  end

  def draw
  end

end
