

class State
  @@current_state = nil
  class << self
    def setState state
      @@current_state = state
    end

    def getState
      return @@current_state
    end
  end

  def update
  end

  def draw
  end

end
