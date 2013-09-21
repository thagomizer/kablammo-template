# Game Info
#
# board -- the game board
#   See: https://github.com/carbonfive/kablammo-strategy/blob/master/lib/strategy/models/board.rb
# robot -- you
#   See: https://github.com/carbonfive/kablammo-strategy/blob/master/lib/strategy/models/robot.rb
# opponents -- opponent robots
#   See: https://github.com/carbonfive/kablammo-strategy/blob/master/lib/strategy/models/robot.rb
#
# Actions:
#
# fire!(skew=0) -- shot at something
# rotate!(degrees) -- rotate the turret
# rest -- rest and reload
# move_north! -- move north
# move_south! -- move south
# move_east! -- move east
# move_west! -- move west

@enemy = nil
@ticks = 0

on_turn do
  @ticks += 1

# If out of ammo
  # if ammo < 1
  #   rest
  #   # Run away and hide

  # else
  find_enemy unless @enemy
  if @enemy
    next attack(@enemy)
  else
    next move
  end

  #   if @ticks % 5 == 0 or !@enemy
  #     find_enemy
  #   end

  #   if @enemy
  #     attack(@enemy)
  #   else
  #     move
  #   end
  # end
end

def move
  case rand(4)
  when 0
    move_north!
  when 1
    move_south!
  when 2
    move_east!
  when 3
    move_west!
  end
end

def find_enemy
  @enemy = opponents.reject { |o| !can_see?(o) }.min{ |o| distance_to(o) }
end

def attack(enemy)
  if aiming_at?(enemy)
    fire!
  else
    aim_at!(enemy)
  end
end
