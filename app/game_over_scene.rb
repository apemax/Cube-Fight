def tick_game_over_scene args
  args.state.back_to_menu_button ||= {x: 500, y: 96, w: 384, h: 64}
  args.state.play_again_button ||= {x: 180, y: 96, w: 384, h: 64}
  args.state.back_to_menu_button_outline ||= [x: 1300, y: 800, w: 384, h: 64, path: 'sprites/menu-option-outline.png']
  args.state.menu_option_game_over ||= 1
  args.state.menu_option_cooldown ||= 0

  if args.state.menu_option_click_cooldown > 0
    args.state.menu_option_click_cooldown -= 1
  end

  if args.inputs.left and args.state.menu_option_cooldown <= 0 and args.state.menu_option_game_over >= 2
    args.state.menu_option_cooldown += 10
    args.state.menu_option_game_over -= 1
  end
  if args.inputs.right and args.state.menu_option_cooldown <= 0 and args.state.menu_option_game_over <= 1
    args.state.menu_option_cooldown += 10
    args.state.menu_option_game_over += 1
  end

  if args.state.menu_option_cooldown > 0
    args.state.menu_option_cooldown -= 1
  end

  if args.inputs.mouse.intersect_rect?(args.state.play_again_button)
    args.state.menu_option_game_over = 1
  end
  if args.inputs.mouse.intersect_rect?(args.state.back_to_menu_button)
    args.state.menu_option_game_over = 2
  end

  args.outputs.background_color = [255, 255, 255]


  if args.state.match_time_out == true
    args.outputs.labels << {x: 550, y: 600, text: "Times up!", size_enum: 10, a: 255, r: 0, g: 0, b: 0}

    if args.state.player_one_enabled == true and args.state.cpu_one_enabled == true
      args.outputs.labels << {x: 510, y: 500, text: "Player One VS CPU One", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
    end
    if args.state.player_one_enabled == true and args.state.player_two_enabled == true
      args.outputs.labels << {x: 510, y: 500, text: "Player One VS Player Two", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
    end

    args.outputs.labels << {x: 250, y: 450, text: "Hits taken:", size_enum: 10, a: 255, r: 0, g: 0, b: 0}

    if args.state.player_one_enabled == true
      args.outputs.labels << {x: 580, y: 450, text: "#{(args.state.player_one[:hits_taken])}", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
      args.outputs.labels << {x: 580, y: 400, text: "#{(args.state.player_one[:health])}", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
    end
    if args.state.player_two_enabled == true
      args.outputs.labels << {x: 840, y: 450, text: "#{(args.state.player_two[:hits_taken])}", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
      args.outputs.labels << {x: 840, y: 400, text: "#{(args.state.player_two[:health])}", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
    end

    if args.state.cpu_one_enabled == true
      args.outputs.labels << {x: 820, y: 450, text: "#{(args.state.cpu_one[:hits_taken])}", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
      args.outputs.labels << {x: 820, y: 400, text: "#{(args.state.cpu_one[:health])}", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
    end

    args.outputs.labels << {x: 231, y: 400, text: "Health left:", size_enum: 10, a: 255, r: 0, g: 0, b: 0}

    if args.state.player_one_enabled == true and args.state.cpu_one_enabled == true
      if args.state.cpu_one[:health] < args.state.player_one[:health]
        args.outputs.labels << {x: 500, y: 300, text: "Player Wins!", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
      end
      if args.state.player_one[:health] < args.state.cpu_one[:health]
        args.outputs.labels << {x: 540, y: 300, text: "CPU Wins!", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
      end
      if args.state.cpu_one[:health] == args.state.player_one[:health]
        args.outputs.labels << {x: 500, y: 300, text: "Tie!", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
      end
    end

    if args.state.player_one_enabled == true and args.state.player_two_enabled == true
      if args.state.player_two[:health] < args.state.player_one[:health]
        args.outputs.labels << {x: 500, y: 300, text: "Player One Wins!", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
      end
      if args.state.player_one[:health] < args.state.player_two[:health]
        args.outputs.labels << {x: 540, y: 300, text: "Player Two Wins!", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
      end
      if args.state.player_two[:health] == args.state.player_one[:health]
        args.outputs.labels << {x: 500, y: 300, text: "Tie!", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
      end
    end
    args.outputs.labels << {x: 180, y: 150, text: "Play again", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
    args.outputs.labels << {x: 500, y: 150, text: "Main Menu", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
  end

  if args.state.match_ko == true
    args.outputs.labels << {x: 600, y: 600, text: "KO!", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
    if args.state.player_one_enabled == true and args.state.cpu_one_enabled == true
      args.outputs.labels << {x: 510, y: 500, text: "Player One VS CPU One", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
    elsif args.state.player_one_enabled == true and args.state.player_two_enabled == true
      args.outputs.labels << {x: 510, y: 500, text: "Player One VS Player Two", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
    end
    
    args.outputs.labels << {x: 250, y: 450, text: "Hits taken:", size_enum: 10, a: 255, r: 0, g: 0, b: 0}

    if args.state.player_one_enabled == true
      args.outputs.labels << {x: 580, y: 450, text: "#{(args.state.player_one[:hits_taken])}", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
      args.outputs.labels << {x: 580, y: 400, text: "#{(args.state.player_one[:health])}", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
    end
    if args.state.player_two_enabled == true
      args.outputs.labels << {x: 840, y: 450, text: "#{(args.state.player_two[:hits_taken])}", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
      args.outputs.labels << {x: 840, y: 400, text: "#{(args.state.player_two[:health])}", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
    end

    if args.state.cpu_one_enabled == true
      args.outputs.labels << {x: 820, y: 450, text: "#{(args.state.cpu_one[:hits_taken])}", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
      args.outputs.labels << {x: 820, y: 400, text: "#{(args.state.cpu_one[:health])}", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
    end
    args.outputs.labels << {x: 231, y: 400, text: "Health left:", size_enum: 10, a: 255, r: 0, g: 0, b: 0}

    if args.state.player_one_enabled == true and args.state.player_two_enabled == true
      if args.state.player_one[:health] <= 0
        args.outputs.labels << {x: 500, y: 300, text: "Player Two Wins!", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
      elsif args.state.player_two[:health] <= 0
        args.outputs.labels << {x: 500, y: 300, text: "Player One Wins!", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
      elsif args.state.player_one[:health] == args.state.player_two[:health]
        args.outputs.labels << {x: 500, y: 300, text: "Tie!", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
      end
    end

    if args.state.player_one_enabled == true and args.state.cpu_one_enabled == true
      if args.state.player_one[:health] <= 0
        args.outputs.labels << {x: 500, y: 300, text: "CPU One Wins!", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
      elsif args.state.cpu_one[:health] <= 0
        args.outputs.labels << {x: 500, y: 300, text: "Player One Wins!", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
      elsif args.state.cpu_one[:health] == args.state.player_one[:health]
        args.outputs.labels << {x: 500, y: 300, text: "Tie!", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
      end
    end

    args.outputs.labels << {x: 180, y: 150, text: "Play again", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
    args.outputs.labels << {x: 500, y: 150, text: "Main Menu", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
  end

  args.outputs.primitives << args.state.back_to_menu_button_outline

  if args.state.menu_option_game_over == 1
    args.state.back_to_menu_button_outline = [x: 160, y: 96, w: 256, h: 64, path: 'sprites/menu-option-outline.png']
    if args.inputs.keyboard.enter or args.inputs.mouse.click or args.inputs.controller_one.key_down.a and args.state.menu_option_click_cooldown <= 0
      args.state.next_scene = :game_scene
      args.audio[:starting_bell] = {input: "sounds/blastwave_fx_boxingbellring_s08sp.136.mp3", gain: 0.2}
      if args.state.player_one_enabled == true and args.state.cpu_one_enabled == true
        reset_defaults args
        args.state.player_one_enabled = true
        args.state.cpu_one_enabled = true
      end
      if args.state.player_one_enabled == true and args.state.player_two_enabled == true
        reset_defaults args
        args.state.player_one_enabled = true
        args.state.player_two_enabled = true
      end
      args.state.menu_option_click_cooldown += 10
    end
  end
  if args.state.menu_option_game_over == 2
    args.state.back_to_menu_button_outline = [x: 480, y: 96, w: 256, h: 64, path: 'sprites/menu-option-outline.png']
    if args.inputs.keyboard.enter or args.inputs.mouse.click or args.inputs.controller_one.key_down.a and args.state.menu_option_click_cooldown <= 0
      args.state.next_scene = :menu_scene
      reset_defaults args
      args.state.menu_option_click_cooldown += 10
    end
  end
end