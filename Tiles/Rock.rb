require_relative './Assets.rb'
require_relative './singleTile.rb'

class Rock
  def initialize id
    SingleTile.new Assets.stone, 1
  end

  def isSolid
    return true
  end
end
