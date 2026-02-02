def collision_detection args
  args.state.player_one[:x] += args.state.player_one[:dx]
  args.state.player_one_fist_right[:x] += args.state.player_one_fist_right[:dx]
  args.state.player_one_fist_left[:x] += args.state.player_one_fist_left[:dx]

  args.state.cpu_one[:x] += args.state.cpu_one[:dx]
  args.state.cpu_one_attack_zone[:x] += args.state.cpu_one_attack_zone[:dx]
  args.state.cpu_one_fist_right[:x] += args.state.cpu_one_fist_right[:dx]
  args.state.cpu_one_fist_left[:x] += args.state.cpu_one_fist_left[:dx]

=begin
  if args.state.player_one.intersect_rect? args.state.cpu_one
    if args.state.player_one.dx > 0
      args.state.player_one.x = args.state.cpu_one.x - args.state.player_one.w
      args.state.player_one_fist_left.x = args.state.cpu_one.x - args.state.player_one_fist_left.w
      args.state.player_one_fist_right.x = args.state.cpu_one.x - args.state.player_one_fist_right.w
    elsif args.state.player_one.dx < 0
      args.state.player_one.x = args.state.cpu_one.x + args.state.cpu_one.w
      args.state.player_one_fist_left.x = args.state.cpu_one.x + args.state.player_one_fist_left.w
      args.state.player_one_fist_right.x = args.state.cpu_one.x + args.state.player_one_fist_right.w
    end
    args.state.player_one.dx = 0
    args.state.player_one_fist_left.dx = 0
    args.state.player_one_fist_right.dx = 0
  end

  if args.state.cpu_one.intersect_rect? args.state.player_one
    if args.state.cpu_one.dx > 0
      args.state.cpu_one.x = args.state.player_one.x - args.state.cpu_one.w
      args.state.cpu_one_fist_left.x = args.state.player_one.x - args.state.cpu_one_fist_left.w
      args.state.cpu_one_fist_right.x = args.state.player_one.x - args.state.cpu_one_fist_right.w
    elsif args.state.cpu_one.dx < 0
      args.state.cpu_one.x = args.state.player_one.x + args.state.cpu_one.w
      args.state.cpu_one_fist_left.x = args.state.player_one.x + args.state.cpu_one_fist_left.w
      args.state.cpu_one_fist_right.x = args.state.player_one.x + args.state.cpu_one_fist_right.w
    end
    args.state.cpu_one.dx = 0
    args.state.cpu_one_fist_left.dx = 0
    args.state.cpu_one_fist_right.dx = 0
  end
=end

  args.state.player_one[:y] += args.state.player_one[:dy]
  args.state.player_one_fist_right[:y] += args.state.player_one_fist_right[:dy]
  args.state.player_one_fist_left[:y] += args.state.player_one_fist_left[:dy]

  args.state.cpu_one[:y] += args.state.cpu_one[:dy]
  args.state.cpu_one_attack_zone[:y] += args.state.cpu_one_attack_zone[:dy]
  args.state.cpu_one_fist_right[:y] += args.state.cpu_one_fist_right[:dy]
  args.state.cpu_one_fist_left[:y] += args.state.cpu_one_fist_left[:dy]

=begin
  if args.state.player_one.intersect_rect? args.state.cpu_one
    if args.state.player_one.dy > 0
      args.state.player_one.y = args.state.cpu_one.y - args.state.player_one.h
      args.state.player_one_fist_left.y = args.state.cpu_one.y - args.state.player_one_fist_left.h
      args.state.player_one_fist_right.y = args.state.cpu_one.y - args.state.player_one_fist_right.h
    elsif args.state.player_one.dy < 0
      args.state.player_one_fist_left.y = args.state.cpu_one.y + args.state.player_one_fist_left.h
      args.state.player_one_fist_right.y = args.state.cpu_one.y + args.state.player_one_fist_right.h
    end
    args.state.player_one.dy = 0
    args.state.player_one_fist_left.dy = 0
    args.state.player_one_fist_right.dy = 0
  end

  if args.state.cpu_one.intersect_rect? args.state.player_one
    if args.state.cpu_one.dy > 0
      args.state.cpu_one.y = args.state.player_one.y - args.state.cpu_one.h
      args.state.cpu_one_fist_left.y = args.state.player_one.y - args.state.cpu_one_fist_left.h
      args.state.cpu_one_fist_right.y = args.state.player_one.y - args.state.cpu_one_fist_right.h
    elsif args.state.cpu_one.dy < 0
      args.state.cpu_one_fist_left.y = args.state.player_one.y + args.state.cpu_one_fist_left.h
      args.state.cpu_one_fist_right.y = args.state.player_one.y + args.state.cpu_one_fist_right.h
    end
    args.state.cpu_one.dy = 0
    args.state.cpu_one_fist_left.dy = 0
    args.state.cpu_one_fist_right.dy = 0
  end
=end
end