def cpu_one_input args
  # cpu movement
  if args.state.cpu_one_move_timer > 0
    args.state.cpu_one_move_timer -= 1
  end

  if args.state.cpu_one_move_timer == 0
    args.state.cpu_one_move_direction = Numeric.rand(4)
  end

  if args.state.cpu_one[:dx] > 0.5
    args.state.cpu_one[:dx] -= 0.5
    args.state.cpu_one_attack_zone[:dx] -= 0.5
    args.state.cpu_one_fist_right[:dx] -= 0.5
    args.state.cpu_one_fist_left[:dx] -= 0.5
  end
  if args.state.cpu_one[:dx] < -0.5
    args.state.cpu_one[:dx] += 0.5
    args.state.cpu_one_attack_zone[:dx] += 0.5
    args.state.cpu_one_fist_right[:dx] += 0.5
    args.state.cpu_one_fist_left[:dx] += 0.5
  end

  if args.state.cpu_one[:dy] > 0.5
    args.state.cpu_one[:dy] -= 0.5
    args.state.cpu_one_attack_zone[:dy] -= 0.5
    args.state.cpu_one_fist_right[:dy] -= 0.5
    args.state.cpu_one_fist_left[:dy] -= 0.5
  end
  if args.state.cpu_one[:dy] < -0.5
    args.state.cpu_one[:dy] += 0.5
    args.state.cpu_one_attack_zone[:dy] += 0.5
    args.state.cpu_one_fist_right[:dy] += 0.5
    args.state.cpu_one_fist_left[:dy] += 0.5
  end

  if args.state.cpu_one_move_direction == 0
    if args.state.cpu_one_move_timer == 0
      args.state.cpu_one_move_timer += 30
    end
    args.state.cpu_one[:dx] += 0.5
    args.state.cpu_one_attack_zone[:dx] += 0.5
    args.state.cpu_one_fist_right[:dx] += 0.5
    args.state.cpu_one_fist_left[:dx] += 0.5
  elsif args.state.cpu_one_move_direction == 1
    if args.state.cpu_one_move_timer == 0
      args.state.cpu_one_move_timer += 30
    end
    args.state.cpu_one[:dx] -= 0.5
    args.state.cpu_one_attack_zone[:dx] -= 0.5
    args.state.cpu_one_fist_right[:dx] -= 0.5
    args.state.cpu_one_fist_left[:dx] -= 0.5
  elsif args.state.cpu_one_move_direction == 2
    if args.state.cpu_one_move_timer == 0
      args.state.cpu_one_move_timer += 30
    end
    args.state.cpu_one[:dy] += 0.5
    args.state.cpu_one_attack_zone[:dy] += 0.5
    args.state.cpu_one_fist_right[:dy] += 0.5
    args.state.cpu_one_fist_left[:dy] += 0.5
  elsif args.state.cpu_one_move_direction == 3
    if args.state.cpu_one_move_timer == 0
      args.state.cpu_one_move_timer += 30
    end
    args.state.cpu_one[:dy] -= 0.5
    args.state.cpu_one_attack_zone[:dy] -= 0.5
    args.state.cpu_one_fist_right[:dy] -= 0.5
    args.state.cpu_one_fist_left[:dy] -= 0.5
  end

  if args.state.cpu_one[:x] <= 425
    args.state.cpu_one[:x] = 425
    args.state.cpu_one_attack_zone[:x] = 425 - 64
    args.state.cpu_one_fist_right[:x] = 425
    args.state.cpu_one_fist_left[:x] = 425
  end
  if args.state.cpu_one[:x] >= 1216
    args.state.cpu_one[:x] = 1216
    args.state.cpu_one_attack_zone[:x] = 1216 - 64
    args.state.cpu_one_fist_right[:x] = 1216
    args.state.cpu_one_fist_left[:x] = 1216
  end
  if args.state.cpu_one[:y] <= 64
    args.state.cpu_one[:y] = 64
    args.state.cpu_one_attack_zone[:y] = 64 - 64
    args.state.cpu_one_fist_right[:y] = 64
    args.state.cpu_one_fist_left[:y] = 64 + 32
  end
  if args.state.cpu_one[:y] >= 592
    args.state.cpu_one[:y] = 592
    args.state.cpu_one_attack_zone[:y] = 592 - 64
    args.state.cpu_one_fist_right[:y] = 592
    args.state.cpu_one_fist_left[:y] = 592 + 32
  end

  # cpu attack

  if args.state.cpu_one_attack_zone.intersect_rect? args.state.player_one
    args.state.cpu_one_attack_warning_timer_started = true
  end

  if args.state.cpu_one_attack_warning_timer_started == true
    args.state.cpu_one_attack_warning_timer += 1
    if args.state.cpu_one_attack_warning_timer >= 5 && args.state.cpu_one_attack_warning_timer < 10
      args.state.cpu_one_attack_zone[:a] += 50
    end
    if args.state.cpu_one_attack_warning_timer >= 10 && args.state.cpu_one_attack_warning_timer < 15
      args.state.cpu_one_attack_zone[:a] -= 30
    end
    if args.state.cpu_one_attack_warning_timer >= 15 && args.state.cpu_one_attack_warning_timer < 20
      args.state.cpu_one_attack_zone[:a] = 0
      
      if args.state.cpu_one_attack_zone.intersect_rect? args.state.player_one and args.state.cpu_one_fist_left[:cooldown] <= 0
        args.state.cpu_one_fist_left_timer_started = true
      end
    end

    if args.state.cpu_one_attack_warning_timer >= 30
      
      args.state.cpu_one_attack_warning_timer = 0
      args.state.cpu_one_attack_warning_timer_started = false

      if args.state.cpu_one_attack_zone.intersect_rect? args.state.player_one and args.state.cpu_one_fist_right[:cooldown] <= 0
        args.state.cpu_one_fist_right_timer_started = true
      end
    end
  end

  if args.state.cpu_one_fist_right_timer_started == true
    args.state.cpu_one_fist_right_timer += 1
    if args.state.cpu_one_fist_right_timer <= 5
      args.state.cpu_one_fist_right[:dx] -= 5
      args.state.cpu_one_fist_right_forward -= 5
    end

    if args.state.cpu_one_fist_right_timer == 5
      args.state.cpu_one_fist_right[:dx] -= args.state.cpu_one_fist_right_forward
      args.state.cpu_one_fist_right_forward = 0
      if args.state.player_one.intersect_rect? args.state.cpu_one_fist_right and args.state.cpu_one_fist_right[:hit_cooldown] <= 0 and !args.state.player_one.intersect_rect? args.state.cpu_one
        args.state.player_one[:hits] += 1
        args.state.cpu_one_fist_right[:hit_cooldown] += 15
        args.state.hit_effects << {x: args.state.cpu_one_fist_right[:x] + 8, y: args.state.cpu_one_fist_right[:y] + 8, w: 32, h: 32, path: 'sprites/hit-effect-0.png', age: 0}
        args.audio[:hit] = {input: "sounds/pm_rockimpt_source_rock_impact_big_lfe_7_pmsfx_ri2_3951.mp3", gain: 0.2}
      end
    end

    if args.state.cpu_one_fist_right_timer > 5 && args.state.cpu_one_fist_right_timer <= 10
      args.state.cpu_one_fist_right[:dx] += 5
      args.state.cpu_one_fist_right_backward += 5
    end

    if args.state.cpu_one_fist_right_timer >= 10
      args.state.cpu_one_fist_right[:dx] -= args.state.cpu_one_fist_right_backward
      args.state.cpu_one_fist_right_backward = 0
      args.state.cpu_one_fist_right_timer_started = false
      args.state.cpu_one_fist_right_timer = 0
      args.state.cpu_one_fist_right[:cooldown] += 60
    end
  end

  if args.state.cpu_one_fist_left_timer_started == true
    args.state.cpu_one_fist_left_timer += 1
    if args.state.cpu_one_fist_left_timer <= 5
      args.state.cpu_one_fist_left[:dx] -= 5
      args.state.cpu_one_fist_left_forward -= 5
    end

    if args.state.cpu_one_fist_left_timer == 5
      args.state.cpu_one_fist_left[:dx] -= args.state.cpu_one_fist_left_forward
      args.state.cpu_one_fist_left_forward = 0
      if args.state.player_one.intersect_rect? args.state.cpu_one_fist_left and args.state.cpu_one_fist_left[:hit_cooldown] <= 0 and !args.state.player_one.intersect_rect? args.state.cpu_one
        args.state.player_one[:hits] += 1
        args.state.cpu_one_fist_left[:hit_cooldown] += 15
        args.state.hit_effects << {x: args.state.cpu_one_fist_left[:x] + 8, y: args.state.cpu_one_fist_left[:y] + 8, w: 32, h: 32, path: 'sprites/hit-effect-0.png', age: 0}
        args.audio[:hit] = {input: "sounds/pm_rockimpt_source_rock_impact_big_lfe_7_pmsfx_ri2_3951.mp3", gain: 0.2}
      end
    end

    if args.state.cpu_one_fist_left_timer > 5 && args.state.cpu_one_fist_left_timer <= 10
      args.state.cpu_one_fist_left[:dx] += 5
      args.state.cpu_one_fist_left_backward += 5
    end

    if args.state.cpu_one_fist_left_timer >= 10
      args.state.cpu_one_fist_left[:dx] -= args.state.cpu_one_fist_left_backward
      args.state.cpu_one_fist_left_backward = 0
      args.state.cpu_one_fist_left_timer_started = false
      args.state.cpu_one_fist_left_timer = 0
      args.state.cpu_one_fist_left[:cooldown] += 60
    end
  end
end