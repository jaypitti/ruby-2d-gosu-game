require_relative './Assets.rb'
load './Tile.rb'

class Grass < Tile

  def initialize id
    super
    Tile.new Assets.grass, id
  end

  def isSolid
    return false
  end
end
