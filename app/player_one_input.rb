def player_one_input args

  # Dodge input

  if args.inputs.keyboard.key_down.space or args.inputs.controller_one.key_down.l1 && args.state.player_one[:cooldown] <= 0
    if args.state.player_one[:dx] == -5
      args.state.player_one[:dx] -= 15
      args.state.player_one_fist_right[:dx] -= 15
      args.state.player_one_fist_left[:dx] -= 15
    elsif args.state.player_one[:dx] == 5
      args.state.player_one[:dx] += 15
      args.state.player_one_fist_right[:dx] += 15
      args.state.player_one_fist_left[:dx] += 15
    end
    if args.state.player_one[:dy] == -5
      args.state.player_one[:dy] -= 15
      args.state.player_one_fist_right[:dy] -= 15
      args.state.player_one_fist_left[:dy] -= 15
    elsif args.state.player_one[:dy] == 5
      args.state.player_one[:dy] += 15
      args.state.player_one_fist_right[:dy] += 15
      args.state.player_one_fist_left[:dy] += 15
    end
    args.audio[:dodge] = {input: "sounds/foley_rope_spin_in_air_like_lasso_3.mp3", gain: args.state.audio_volume}
    args.state.player_one[:cooldown] += 15
  end

  # Maintain constant movement speed

  if args.state.player_one[:dx] > 5
    args.state.player_one[:dx] -= 1
    args.state.player_one_fist_right[:dx] -= 1
    args.state.player_one_fist_left[:dx] -= 1
  end
  if args.state.player_one[:dx] < -5
    args.state.player_one[:dx] += 1
    args.state.player_one_fist_right[:dx] += 1
    args.state.player_one_fist_left[:dx] += 1
  end

  if args.state.player_one[:dy] > 5
    args.state.player_one[:dy] -= 1
    args.state.player_one_fist_right[:dy] -= 1
    args.state.player_one_fist_left[:dy] -= 1
  end
  if args.state.player_one[:dy] < -5
    args.state.player_one[:dy] += 1
    args.state.player_one_fist_right[:dy] += 1
    args.state.player_one_fist_left[:dy] += 1
  end

  # Player input

  if args.inputs.keyboard.key_held.a or args.inputs.controller_one.left
    if args.state.player_one[:dx] == 0
      args.state.player_one[:dx] -= 5
      args.state.player_one_fist_right[:dx] -= 5
      args.state.player_one_fist_left[:dx] -= 5
    end
  end
  if !args.inputs.keyboard.key_held.a or args.inputs.controller_one.left
    if args.state.player_one[:dx] == -5
      args.state.player_one[:dx] += 5
      args.state.player_one_fist_right[:dx] += 5
      args.state.player_one_fist_left[:dx] += 5
    end
  end
  if args.inputs.keyboard.key_held.d or args.inputs.controller_one.right
    if args.state.player_one[:dx] == 0
      args.state.player_one[:dx] += 5
      args.state.player_one_fist_right[:dx] += 5
      args.state.player_one_fist_left[:dx] += 5
    end
  end
  if !args.inputs.keyboard.key_held.d or args.inputs.controller_one.right
    if args.state.player_one[:dx] == 5
      args.state.player_one[:dx] -= 5
      args.state.player_one_fist_right[:dx] -= 5
      args.state.player_one_fist_left[:dx] -= 5
    end
  end
  if args.inputs.keyboard.key_held.w or args.inputs.controller_one.up
    if args.state.player_one[:dy] == 0
      args.state.player_one[:dy] += 5
      args.state.player_one_fist_right[:dy] += 5
      args.state.player_one_fist_left[:dy] += 5
    end
  end
  if !args.inputs.keyboard.key_held.w or args.inputs.controller_one.up
    if args.state.player_one[:dy] == 5
      args.state.player_one[:dy] -= 5
      args.state.player_one_fist_right[:dy] -= 5
      args.state.player_one_fist_left[:dy] -= 5
    end
  end
  if args.inputs.keyboard.key_held.s or args.inputs.controller_one.down
    if args.state.player_one[:dy] == 0
      args.state.player_one[:dy] -= 5
      args.state.player_one_fist_right[:dy] -= 5
      args.state.player_one_fist_left[:dy] -= 5
    end
  end
  if !args.inputs.keyboard.key_held.s or args.inputs.controller_one.down
    if args.state.player_one[:dy] == -5
      args.state.player_one[:dy] += 5
      args.state.player_one_fist_right[:dy] += 5
      args.state.player_one_fist_left[:dy] += 5
    end
  end

  # Stop player from exiting screen

  if args.state.player_one[:x] <= 0
    args.state.player_one[:x] = 0
    args.state.player_one_fist_right[:x] = 0 + 32
    args.state.player_one_fist_left[:x] = 0 + 32
  end
  if args.state.player_one[:x] >= 1216
    args.state.player_one[:x] = 1216
    args.state.player_one_fist_right[:x] = 1216 + 32
    args.state.player_one_fist_left[:x] = 1216 + 32
  end
  if args.state.player_one[:y] <= 0
    args.state.player_one[:y] = 0
    args.state.player_one_fist_right[:y] = 0
    args.state.player_one_fist_left[:y] = 0 + 32
  end
  if args.state.player_one[:y] >= 656
    args.state.player_one[:y] = 656
    args.state.player_one_fist_right[:y] = 656
    args.state.player_one_fist_left[:y] = 656 + 32
  end

  # Start player attack cooldown timers

  if args.inputs.keyboard.key_down.two or args.inputs.keyboard.key_down.h or args.inputs.controller_one.key_down.x && args.state.player_one[:cooldown] <= 0
    args.state.player_one_fist_right_timer_started = true
  end

  if args.inputs.keyboard.key_down.one or args.inputs.keyboard.key_down.g or args.inputs.controller_one.key_down.y && args.state.player_one[:cooldown] <= 0
    args.state.player_one_fist_left_timer_started = true
  end

  # Player fist right input and collision detection

  if args.state.player_one_fist_right_timer_started == true
    args.state.player_one_fist_right_timer += 1
    if args.state.player_one_fist_right_timer <= 5
      args.state.player_one_fist_right[:dx] += 5
      args.state.player_one_fist_right_forward += 5
    end

    if args.state.player_one_fist_right_timer == 5
      args.state.player_one_fist_right[:dx] -= args.state.player_one_fist_right_forward
      args.state.player_one_fist_right_forward = 0
      if args.state.player_one_enabled == true and args.state.cpu_one_enabled == true
        if args.state.cpu_one.intersect_rect? args.state.player_one_fist_right and args.state.player_one_fist_right[:cooldown] <= 0 and !args.state.cpu_one.intersect_rect? args.state.player_one
          args.state.cpu_one[:hits_taken] += 1
          args.state.cpu_one[:health] -= 10
          args.state.cpu_one_health_bar[:w] -= 50
          args.state.cpu_one_health_bar[:x] += 50
          args.state.player_one_fist_right[:cooldown] += 15
          args.state.hit_effects << {x: args.state.player_one_fist_right[:x] + 32, y: args.state.player_one_fist_right[:y] + 8, w: 32, h: 32, path: 'sprites/hit-effect-0.png', age: 0}
          args.audio[:hit] = {input: "sounds/pm_rockimpt_source_rock_impact_big_lfe_7_pmsfx_ri2_3951.mp3", gain: args.state.audio_volume}
        end
      elsif args.state.player_one_enabled == true and args.state.player_two_enabled == true
        if args.state.player_two.intersect_rect? args.state.player_one_fist_right and args.state.player_one_fist_right[:cooldown] <= 0 and !args.state.player_two.intersect_rect? args.state.player_one
          args.state.player_two[:hits_taken] += 1
          args.state.player_two[:health] -= 10
          args.state.player_two_health_bar[:w] -= 50
          args.state.player_two_health_bar[:x] += 50
          args.state.player_one_fist_right[:cooldown] += 15
          args.state.hit_effects << {x: args.state.player_one_fist_right[:x] + 32, y: args.state.player_one_fist_right[:y] + 8, w: 32, h: 32, path: 'sprites/hit-effect-0.png', age: 0}
          args.audio[:hit] = {input: "sounds/pm_rockimpt_source_rock_impact_big_lfe_7_pmsfx_ri2_3951.mp3", gain: args.state.audio_volume}
        end
      end
    end

    if args.state.player_one_fist_right_timer > 5 && args.state.player_one_fist_right_timer <= 10
      args.state.player_one_fist_right[:dx] -= 5
      args.state.player_one_fist_right_backward -= 5
    end

    if args.state.player_one_fist_right_timer == 10
      args.state.player_one_fist_right[:dx] -= args.state.player_one_fist_right_backward
      args.state.player_one_fist_right_backward = 0
      args.state.player_one_fist_right_timer_started = false
      args.state.player_one_fist_right_timer = 0
      args.state.player_one_fist_right[:x] = args.state.player_one[:x] + 32
    end
  end

  # Player fist left input and collision detection

  if args.state.player_one_fist_left_timer_started == true
    args.state.player_one_fist_left_timer += 1
    if args.state.player_one_fist_left_timer <= 5
      args.state.player_one_fist_left[:dx] += 5
      args.state.player_one_fist_left_forward += 5
    end

    if args.state.player_one_fist_left_timer == 5
      args.state.player_one_fist_left[:dx] -= args.state.player_one_fist_left_forward
      args.state.player_one_fist_left_forward = 0
      if args.state.player_one_enabled == true and args.state.cpu_one_enabled == true
        if args.state.cpu_one.intersect_rect? args.state.player_one_fist_left and args.state.player_one_fist_left[:cooldown] <= 0 and !args.state.cpu_one.intersect_rect? args.state.player_one
          args.state.cpu_one[:hits_taken] += 1
          args.state.cpu_one[:health] -= 10
          args.state.cpu_one_health_bar[:w] -= 50
          args.state.cpu_one_health_bar[:x] += 50
          args.state.player_one_fist_left[:cooldown] += 15
          args.state.hit_effects << {x: args.state.player_one_fist_left[:x] + 32, y: args.state.player_one_fist_left[:y] + 8, w: 32, h: 32, path: 'sprites/hit-effect-0.png', age: 0}
          args.audio[:hit] = {input: "sounds/pm_rockimpt_source_rock_impact_big_lfe_7_pmsfx_ri2_3951.mp3", gain: args.state.audio_volume}
        end
      elsif args.state.player_one_enabled == true and args.state.player_two_enabled == true
        if args.state.player_two.intersect_rect? args.state.player_one_fist_left and args.state.player_one_fist_left[:cooldown] <= 0 and !args.state.player_two.intersect_rect? args.state.player_one
          args.state.player_two[:hits_taken] += 1
          args.state.player_two[:health] -= 10
          args.state.player_two_health_bar[:w] -= 50
          args.state.player_two_health_bar[:x] += 50
          args.state.player_one_fist_left[:cooldown] += 15
          args.state.hit_effects << {x: args.state.player_one_fist_left[:x] + 32, y: args.state.player_one_fist_left[:y] + 8, w: 32, h: 32, path: 'sprites/hit-effect-0.png', age: 0}
          args.audio[:hit] = {input: "sounds/pm_rockimpt_source_rock_impact_big_lfe_7_pmsfx_ri2_3951.mp3", gain: args.state.audio_volume}
        end
      end
    end

    if args.state.player_one_fist_left_timer > 5 && args.state.player_one_fist_left_timer <= 10
      args.state.player_one_fist_left[:dx] -= 5
      args.state.player_one_fist_left_backward -= 5
    end

    if args.state.player_one_fist_left_timer == 10
      args.state.player_one_fist_left[:dx] -= args.state.player_one_fist_left_backward
      args.state.player_one_fist_left_backward = 0
      args.state.player_one_fist_left_timer_started = false
      args.state.player_one_fist_left_timer = 0
      args.state.player_one_fist_left[:x] = args.state.player_one[:x] + 32
    end
  end
end