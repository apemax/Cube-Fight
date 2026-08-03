def tick_game_scene args
  defaults args

  args.state.time_frame += 1

  if args.state.time_frame == 60
    args.state.time_frame = 0
    args.state.time_seconds += 1
    args.state.match_timer -= 1

    if args.state.time_seconds == 60
      args.state.time_seconds = 0
      args.state.time_minutes += 1
    end
  end

  if args.inputs.keyboard.key_down.o and args.state.debug_enabled == false
    args.state.debug_enabled = true
  elsif args.inputs.keyboard.key_down.o and args.state.debug_enabled == true
    args.state.debug_enabled = false
  end

  if args.inputs.keyboard.key_down.p or args.inputs.controller_one.key_down.start
    args.state.next_scene = :pause_scene
  end

  if args.state.debug_enabled
    debug args
  end

  if args.state.player_one_enabled == true
    if args.state.player_one_fist_left[:cooldown] > 0
      args.state.player_one_fist_left[:cooldown] -= 1
    end
    if args.state.player_one_fist_right[:cooldown] > 0
      args.state.player_one_fist_right[:cooldown] -= 1
    end

    if args.state.player_one[:cooldown] > 0
      args.state.player_one[:cooldown] -= 1
    end

    player_one_input args
  end

  if args.state.player_two_enabled == true
    if args.state.player_two_fist_left[:cooldown] > 0
      args.state.player_two_fist_left[:cooldown] -= 1
    end
    if args.state.player_two_fist_right[:cooldown] > 0
      args.state.player_two_fist_right[:cooldown] -= 1
    end

    if args.state.player_two[:cooldown] > 0
      args.state.player_two[:cooldown] -= 1
    end

    player_two_input args
  end

  if args.state.cpu_one_enabled == true
    if args.state.cpu_one_fist_left[:cooldown] > 0
      args.state.cpu_one_fist_left[:cooldown] -= 1
    end

    if args.state.cpu_one_fist_right[:cooldown] > 0
      args.state.cpu_one_fist_right[:cooldown] -= 1
    end

    if args.state.cpu_one_fist_left[:hit_cooldown] > 0
      args.state.cpu_one_fist_left[:hit_cooldown] -= 1
    end
    if args.state.cpu_one_fist_right[:hit_cooldown] > 0
      args.state.cpu_one_fist_right[:hit_cooldown] -= 1
    end

    cpu_one_input args
  end

  update_hit_effects args

  collision_detection args

  args.outputs.background_color = [255, 255, 255]
  if args.state.cpu_attack_warning == true and args.state.cpu_one_enabled == true
    args.outputs.primitives << args.state.cpu_one_attack_zone
  end
  if args.state.player_one_enabled == true
    args.outputs.primitives << args.state.player_one
    args.outputs.primitives << args.state.player_one_health_bar
    args.outputs.primitives << args.state.player_one_fist_right
    args.outputs.primitives << args.state.player_one_fist_left
  end
  if args.state.player_two_enabled == true
    args.outputs.primitives << args.state.player_two
    args.outputs.primitives << args.state.player_two_health_bar
    args.outputs.primitives << args.state.player_two_fist_right
    args.outputs.primitives << args.state.player_two_fist_left
  end
  if args.state.cpu_one_enabled == true
    args.outputs.primitives << args.state.cpu_one
    args.outputs.primitives << args.state.cpu_one_health_bar
    args.outputs.primitives << args.state.cpu_one_fist_left
    args.outputs.primitives << args.state.cpu_one_fist_right
  end
  args.outputs.primitives << args.state.hit_effects
  args.outputs.primitives << args.state.health_bar_outline_right
  args.outputs.primitives << args.state.health_bar_outline_left
  if args.state.player_one_enabled == true
    args.outputs.labels << {x: 50, y: 660, text: "Player One", size_enum: 5, a: 255, r: 0, g: 0, b: 0}
  end
   if args.state.player_two_enabled == true
    args.outputs.labels << {x: 1050, y: 660, text: "Player Two", size_enum: 5, a: 255, r: 0, g: 0, b: 0}
  end
  if args.state.cpu_one_enabled == true
    args.outputs.labels << {x: 1050, y: 660, text: "CPU One", size_enum: 5, a: 255, r: 0, g: 0, b: 0}
  end
  args.outputs.labels << {x: 560, y: 700, text: "Time: #{(args.state.match_timer)}", size_enum: 10, a: 255, r: 0, g: 0, b: 0}

  if args.state.match_timer <= 0
    args.state.match_time_out = true
    args.state.next_scene = :game_over_scene
  end
  if args.state.player_one_enabled == true and args.state.cpu_one_enabled == true
    if args.state.player_one[:health] <= 0 or args.state.cpu_one[:health] <= 0
      args.state.match_ko = true
      args.state.next_scene = :game_over_scene
    end
  elsif args.state.player_one_enabled == true and args.state.player_two_enabled == true
    if args.state.player_one[:health] <= 0 or args.state.player_two[:health] <= 0
      args.state.match_ko = true
      args.state.next_scene = :game_over_scene
    end
  end
end