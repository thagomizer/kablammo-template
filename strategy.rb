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

on_turn do
# If out of ammo
  if ammo < 1
    rest
    # Run away and hide

  else
    # Find closest apponent
    enemy = opponents.reject { |o| !can_see?(o) }.min{ |o| distance_to(o) }

    if aiming_at?(enemy)
      fire!
    else
      aim_at!(enemy)
    end
  end
end
