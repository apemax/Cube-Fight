def tick_menu_scene args
  args.state.menu_option_player_vs_cpu ||= {x: 180, y: 416, w: 384, h: 64}
  args.state.menu_option_player_one_vs_player_two ||= {x: 180, y: 316, w: 384, h: 64}
  args.state.menu_option_how_to_play ||= {x: 180, y: 216, w: 384, h: 64}
  args.state.menu_option_options ||= {x: 180, y: 116, w: 384, h: 64}
  args.state.menu_option_exit ||= {x: 180, y: 16, w: 384, h: 64}
  args.state.menu_option_outline ||= [x: 1300, y: 800, w: 256, h: 64, path: 'sprites/menu-option-outline.png']
  args.state.menu_option_main ||= 1
  args.state.menu_option_cooldown ||= 0

  if args.inputs.up and args.state.menu_option_cooldown <= 0 and args.state.menu_option_main >= 2
    args.state.menu_option_cooldown += 10
    args.state.menu_option_main -= 1
  end
  if args.inputs.down and args.state.menu_option_cooldown <= 0 and args.state.menu_option_main <= 3
    args.state.menu_option_cooldown += 10
    args.state.menu_option_main += 1
  end

  if args.state.menu_option_cooldown > 0
    args.state.menu_option_cooldown -= 1
  end
  if args.state.menu_option_click_cooldown > 0
    args.state.menu_option_click_cooldown -= 1
  end

  if args.inputs.mouse.intersect_rect?(args.state.menu_option_player_vs_cpu)
    args.state.menu_option_main = 1
  end
  if args.inputs.mouse.intersect_rect?(args.state.menu_option_player_one_vs_player_two)
    args.state.menu_option_main = 2
  end
  if args.inputs.mouse.intersect_rect?(args.state.menu_option_how_to_play)
    args.state.menu_option_main = 3
  end
  if args.inputs.mouse.intersect_rect?(args.state.menu_option_options)
    args.state.menu_option_main = 4
  end
  if args.inputs.mouse.intersect_rect?(args.state.menu_option_exit)
    args.state.menu_option_main = 5
  end

  args.outputs.background_color = [255, 255, 255]
  args.outputs.labels << {x: 180, y: 620, text: "20 Second Cube Fight", size_enum: 40, a: 255, r: 0, g: 0, b: 0}
  args.outputs.labels << {x: 180, y: 480, text: "Player VS CPU", size_enum: 20, a: 255, r: 0, g: 0, b: 0}
  args.outputs.labels << {x: 180, y: 380, text: "Player VS Player", size_enum: 20, a: 255, r: 0, g: 0, b: 0}
  args.outputs.labels << {x: 180, y: 280, text: "How to Play", size_enum: 20, a: 255, r: 0, g: 0, b: 0}
  args.outputs.labels << {x: 180, y: 180, text: "Options", size_enum: 20, a: 255, r: 0, g: 0, b: 0}
  args.outputs.labels << {x: 180, y: 80, text: "Exit", size_enum: 20, a: 255, r: 0, g: 0, b: 0}
  args.outputs.primitives << args.state.menu_option_outline

  if args.state.menu_option_main == 1
    args.state.menu_option_outline = [x: 180, y: 416, w: 256, h: 64, path: 'sprites/menu-option-outline.png']
    if args.inputs.keyboard.enter or args.inputs.mouse.click or args.inputs.controller_one.key_down.a  and args.state.menu_option_click_cooldown <= 0
      args.state.player_one_enabled = true
      args.state.player_two_enabled = false
      args.state.cpu_one_enabled = true
      args.state.next_scene = :game_scene
      args.audio[:starting_bell] = {input: "sounds/blastwave_fx_boxingbellring_s08sp.136.mp3", gain: 0.2}
      args.state.menu_option_click_cooldown += 10
    end
  end
  if args.state.menu_option_main == 2
    args.state.menu_option_outline = [x: 180, y: 316, w: 256, h: 64, path: 'sprites/menu-option-outline.png']
    if args.inputs.keyboard.enter or args.inputs.mouse.click or args.inputs.controller_one.key_down.a  and args.state.menu_option_click_cooldown <= 0
      args.state.player_one_enabled = true
      args.state.player_two_enabled = true
      args.state.cpu_one_enabled = false
      args.state.next_scene = :game_scene
      args.audio[:starting_bell] = {input: "sounds/blastwave_fx_boxingbellring_s08sp.136.mp3", gain: 0.2}
      args.state.menu_option_click_cooldown += 10
    end
  end
  if args.state.menu_option_main == 3
    args.state.menu_option_outline = [x: 180, y: 216, w: 256, h: 64, path: 'sprites/menu-option-outline.png']
    if args.inputs.keyboard.enter or args.inputs.mouse.click or args.inputs.controller_one.key_down.a and args.state.menu_option_click_cooldown <= 0
      args.state.next_scene = :how_to_play_scene
      args.state.menu_option_click_cooldown += 10
    end
  end
  if args.state.menu_option_main == 4
    args.state.menu_option_outline = [x: 180, y: 116, w: 256, h: 64, path: 'sprites/menu-option-outline.png']
    if args.inputs.keyboard.enter or args.inputs.mouse.click or args.inputs.controller_one.key_down.a and args.state.menu_option_click_cooldown <= 0
      args.state.next_scene = :options_scene
      args.state.menu_option_click_cooldown += 10
    end
  end
  if args.state.menu_option_main == 5
    args.state.menu_option_outline = [x: 180, y: 16, w: 256, h: 64, path: 'sprites/menu-option-outline.png']
    if args.inputs.keyboard.enter or args.inputs.mouse.click or args.inputs.controller_one.key_down.a
      GTK.request_quit
    end
  end
end