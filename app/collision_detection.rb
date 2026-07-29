def collision_detection args

  # Move player one sprite

  if args.state.player_one_enabled == true
    args.state.player_one[:x] += args.state.player_one[:dx]
    args.state.player_one_fist_right[:x] += args.state.player_one_fist_right[:dx]
    args.state.player_one_fist_left[:x] += args.state.player_one_fist_left[:dx]
  end

  # Move player two sprite

  if args.state.player_two_enabled == true
    args.state.player_two[:x] += args.state.player_two[:dx]
    args.state.player_two_fist_right[:x] += args.state.player_two_fist_right[:dx]
    args.state.player_two_fist_left[:x] += args.state.player_two_fist_left[:dx]
  end

  # Move CPU one sprite

  if args.state.cpu_one_enabled == true
    args.state.cpu_one[:x] += args.state.cpu_one[:dx]
    args.state.cpu_one_attack_zone[:x] += args.state.cpu_one_attack_zone[:dx]
    args.state.cpu_one_fist_right[:x] += args.state.cpu_one_fist_right[:dx]
    args.state.cpu_one_fist_left[:x] += args.state.cpu_one_fist_left[:dx]
  end

  # Check for collision between player one and CPU one on the x axis

  if args.state.player_one_enabled == true and args.state.cpu_one_enabled == true
    if args.state.player_one.intersect_rect? args.state.cpu_one
      if args.state.player_one.dx > 0
        args.state.player_one.x = args.state.cpu_one.x - args.state.player_one.w
        args.state.player_one_fist_left.x = args.state.cpu_one.x - args.state.player_one_fist_left.w
        args.state.player_one_fist_right.x = args.state.cpu_one.x - args.state.player_one_fist_right.w
      elsif args.state.player_one.dx < 0
        args.state.player_one.x = args.state.cpu_one.x + args.state.cpu_one.w
        args.state.player_one_fist_left.x = args.state.cpu_one.x + args.state.player_one_fist_left.w + args.state.cpu_one.w
        args.state.player_one_fist_right.x = args.state.cpu_one.x + args.state.player_one_fist_right.w + args.state.cpu_one.w
      end
      args.state.player_one.dx = 0
      args.state.player_one_fist_left.dx = 0
      args.state.player_one_fist_right.dx = 0
      args.state.player_one_fist_right_backward = 0
      args.state.player_one_fist_right_forward = 0
      args.state.player_one_fist_left_backward = 0
      args.state.player_one_fist_left_forward = 0
    end

    if args.state.cpu_one.intersect_rect? args.state.player_one
      if args.state.cpu_one.dx > 0
        args.state.cpu_one.x = args.state.player_one.x - args.state.cpu_one.w
        args.state.cpu_one_fist_left.x = args.state.player_one.x - args.state.cpu_one.w
        args.state.cpu_one_fist_right.x = args.state.player_one.x - args.state.cpu_one.w
        args.state.cpu_one_attack_zone.x = args.state.cpu_one.x - 64
      elsif args.state.cpu_one.dx < 0
        args.state.cpu_one.x = args.state.player_one.x + args.state.cpu_one.w
        args.state.cpu_one_fist_left.x = args.state.player_one.x + args.state.player_one.w
        args.state.cpu_one_fist_right.x = args.state.player_one.x + args.state.player_one.w
        args.state.cpu_one_attack_zone.x = args.state.cpu_one.x - 64
      end
      args.state.cpu_one.dx = 0
      args.state.cpu_one_fist_left.dx = 0
      args.state.cpu_one_fist_right.dx = 0
      args.state.cpu_one_attack_zone.dx = 0
      args.state.cpu_one_fist_right_backward = 0
      args.state.cpu_one_fist_right_forward = 0
      args.state.cpu_one_fist_left_backward = 0
      args.state.cpu_one_fist_left_forward = 0
    end
  end

  # Check for collision between player one and player two on the x axis

  if args.state.player_one_enabled == true and args.state.player_two_enabled == true
    if args.state.player_one.intersect_rect? args.state.player_two
      if args.state.player_one.dx > 0
        args.state.player_one.x = args.state.player_two.x - args.state.player_one.w
        args.state.player_one_fist_left.x = args.state.player_two.x - args.state.player_one_fist_left.w
        args.state.player_one_fist_right.x = args.state.player_two.x - args.state.player_one_fist_right.w
      elsif args.state.player_one.dx < 0
        args.state.player_one.x = args.state.player_two.x + args.state.player_two.w
        args.state.player_one_fist_left.x = args.state.player_two.x + args.state.player_one_fist_left.w + args.state.player_two.w
        args.state.player_one_fist_right.x = args.state.player_two.x + args.state.player_one_fist_right.w + args.state.player_two.w
      end
      args.state.player_one.dx = 0
      args.state.player_one_fist_left.dx = 0
      args.state.player_one_fist_right.dx = 0
      args.state.player_one_fist_right_backward = 0
      args.state.player_one_fist_right_forward = 0
      args.state.player_one_fist_left_backward = 0
      args.state.player_one_fist_left_forward = 0
    end

    if args.state.player_two.intersect_rect? args.state.player_one
      if args.state.player_two.dx > 0
        args.state.player_two.x = args.state.player_one.x - args.state.player_two.w
        args.state.player_two_fist_left.x = args.state.player_one.x - args.state.player_two.w
        args.state.player_two_fist_right.x = args.state.player_one.x - args.state.player_two.w
      elsif args.state.player_two.dx < 0
        args.state.player_two.x = args.state.player_one.x + args.state.player_two.w
        args.state.player_two_fist_left.x = args.state.player_one.x + args.state.player_one.w
        args.state.player_two_fist_right.x = args.state.player_one.x + args.state.player_one.w
      end
      args.state.player_two.dx = 0
      args.state.player_two_fist_left.dx = 0
      args.state.player_two_fist_right.dx = 0
      args.state.player_two_fist_right_backward = 0
      args.state.player_two_fist_right_forward = 0
      args.state.player_two_fist_left_backward = 0
      args.state.player_two_fist_left_forward = 0
    end
  end

  # Move player one sprite

  if args.state.player_one_enabled == true
    args.state.player_one[:y] += args.state.player_one[:dy]
    args.state.player_one_fist_right[:y] += args.state.player_one_fist_right[:dy]
    args.state.player_one_fist_left[:y] += args.state.player_one_fist_left[:dy]
  end

  # Move player two sprite

  if args.state.player_two_enabled == true
    args.state.player_two[:y] += args.state.player_two[:dy]
    args.state.player_two_fist_right[:y] += args.state.player_two_fist_right[:dy]
    args.state.player_two_fist_left[:y] += args.state.player_two_fist_left[:dy]
  end

  # Move CPU one sprite

  if args.state.cpu_one_enabled == true
    args.state.cpu_one[:y] += args.state.cpu_one[:dy]
    args.state.cpu_one_attack_zone[:y] += args.state.cpu_one_attack_zone[:dy]
    args.state.cpu_one_fist_right[:y] += args.state.cpu_one_fist_right[:dy]
    args.state.cpu_one_fist_left[:y] += args.state.cpu_one_fist_left[:dy]
  end

  # Check for collision between player one and CPU one on the y axis

  if args.state.player_one_enabled == true and args.state.cpu_one_enabled == true
    if args.state.player_one.intersect_rect? args.state.cpu_one
      if args.state.player_one.dy > 0
        args.state.player_one.y = args.state.cpu_one.y - args.state.player_one.h
        args.state.player_one_fist_left.y = args.state.cpu_one.y - args.state.player_one_fist_left.h - 16
        args.state.player_one_fist_right.y = args.state.cpu_one.y - args.state.player_one_fist_right.h - 16 - 32
      elsif args.state.player_one.dy < 0
        args.state.player_one.y = args.state.cpu_one.y + args.state.player_one.h
        args.state.player_one_fist_left.y = args.state.cpu_one.y + args.state.player_one_fist_left.h + 48
        args.state.player_one_fist_right.y = args.state.cpu_one.y + args.state.player_one_fist_right.h + 48 + 32
      end
      args.state.player_one.dy = 0
      args.state.player_one_fist_left.dy = 0
      args.state.player_one_fist_right.dy = 0
    end

    if args.state.cpu_one.intersect_rect? args.state.player_one
      if args.state.cpu_one.dy > 0
        args.state.cpu_one.y = args.state.player_one.y - args.state.cpu_one.h
        args.state.cpu_one_fist_left.y = args.state.player_one.y - args.state.cpu_one_fist_left.h - 16
        args.state.cpu_one_fist_right.y = args.state.player_one.y - args.state.cpu_one_fist_right.h - 16 - 32
        args.state.cpu_one_attack_zone.y = args.state.cpu_one.y - 64
      elsif args.state.cpu_one.dy < 0
        args.state.cpu_one.y = args.state.player_one.y + args.state.cpu_one.h
        args.state.cpu_one_fist_left.y = args.state.player_one.y + args.state.cpu_one_fist_left.h + 48
        args.state.cpu_one_fist_right.y = args.state.player_one.y + args.state.cpu_one_fist_right.h + 48 + 32
        args.state.cpu_one_attack_zone.y = args.state.cpu_one.y - 64
      end
      args.state.cpu_one.dy = 0
      args.state.cpu_one_fist_left.dy = 0
      args.state.cpu_one_fist_right.dy = 0
      args.state.cpu_one_attack_zone.dy = 0
    end
  end

  # Check for collision between player one and player two on the y axis

  if args.state.player_one_enabled == true and args.state.player_two_enabled == true
    if args.state.player_one.intersect_rect? args.state.player_two
      if args.state.player_one.dy > 0
        args.state.player_one.y = args.state.player_two.y - args.state.player_one.h
        args.state.player_one_fist_left.y = args.state.player_two.y - args.state.player_one_fist_left.h - 16
        args.state.player_one_fist_right.y = args.state.player_two.y - args.state.player_one_fist_right.h - 16 - 32
      elsif args.state.player_one.dy < 0
        args.state.player_one.y = args.state.player_two.y + args.state.player_one.h
        args.state.player_one_fist_left.y = args.state.player_two.y + args.state.player_one_fist_left.h + 48
        args.state.player_one_fist_right.y = args.state.player_two.y + args.state.player_one_fist_right.h + 48 + 32
      end
      args.state.player_one.dy = 0
      args.state.player_one_fist_left.dy = 0
      args.state.player_one_fist_right.dy = 0
    end

    if args.state.player_two.intersect_rect? args.state.player_one
      if args.state.player_two.dy > 0
        args.state.player_two.y = args.state.player_one.y - args.state.player_two.h
        args.state.player_two_fist_left.y = args.state.player_one.y - args.state.player_two_fist_left.h - 16
        args.state.player_two_fist_right.y = args.state.player_one.y - args.state.player_two_fist_right.h - 16 - 32
      elsif args.state.player_two.dy < 0
        args.state.player_two.y = args.state.player_one.y + args.state.player_two.h
        args.state.player_two_fist_left.y = args.state.player_one.y + args.state.player_two_fist_left.h + 48
        args.state.player_two_fist_right.y = args.state.player_one.y + args.state.player_two_fist_right.h + 48 + 32
      end
      args.state.player_two.dy = 0
      args.state.player_two_fist_left.dy = 0
      args.state.player_two_fist_right.dy = 0
      args.state.player_two_fist_right_backward = 0
      args.state.player_two_fist_right_forward = 0
      args.state.player_two_fist_left_backward = 0
      args.state.player_two_fist_left_forward = 0
    end
  end
end