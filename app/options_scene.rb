def tick_options_scene args
  args.state.cpu_attack_warning_button ||= {x: 180, y: 546, w: 384, h: 64}
  args.state.audio_volume_option ||= {x: 180, y: 446, w: 384, h: 64}
  args.state.audio_volume_up_button ||= {x: 690, y: 446, w: 64, h: 64}
  args.state.audio_volume_down_button ||= {x: 580, y: 446, w: 64, h: 64}
  args.state.options_menu_back_to_menu_button ||= {x: 180, y: 96, w: 384, h: 64}
  args.state.button_outline ||= [x: 1300, y: 800, w: 384, h: 64, path: 'sprites/menu-option-outline.png']
  args.state.audio_volume_button_outline ||= [x: 1300, y: 800, w: 64, h: 64, path: 'sprites/menu-option-outline.png']
  args.state.menu_option ||= 1
  args.state.menu_option_cooldown ||= 0

  if args.inputs.up and args.state.menu_option_cooldown <= 0 and args.state.menu_option >= 2
    args.state.menu_option_cooldown += 10
    args.state.menu_option -= 1
  end
  if args.inputs.down and args.state.menu_option_cooldown <= 0 and args.state.menu_option <= 2
    args.state.menu_option_cooldown += 10
    args.state.menu_option += 1
  end

  if args.state.menu_option_cooldown > 0
    args.state.menu_option_cooldown -= 1
  end

  if args.state.menu_option_click_cooldown > 0
    args.state.menu_option_click_cooldown -= 1
  end

  if args.inputs.mouse.intersect_rect?(args.state.cpu_attack_warning_button)
    args.state.menu_option = 1
  end
  if args.inputs.mouse.intersect_rect?(args.state.audio_volume_option)
    args.state.menu_option = 2
  end
  if args.inputs.mouse.intersect_rect?(args.state.options_menu_back_to_menu_button)
    args.state.menu_option = 3
  end

  if args.state.menu_option == 1
    args.state.button_outline = [x: 160, y: 546, w: 390, h: 64, path: 'sprites/menu-option-outline.png']
    if args.inputs.keyboard.enter or args.inputs.mouse.click or args.inputs.controller_one.key_down.a and args.state.menu_option_click_cooldown <= 0
      if args.state.cpu_attack_warning == true
        args.state.cpu_attack_warning = false
      elsif args.state.cpu_attack_warning == false
        args.state.cpu_attack_warning = true
      end
      args.state.menu_option_click_cooldown += 10
    end
  end
  if args.state.menu_option == 2
    args.state.button_outline = [x: 160, y: 446, w: 390, h: 64, path: 'sprites/menu-option-outline.png']
    if args.inputs.right and args.state.menu_option_click_cooldown <= 0
      if args.state.audio_volume < 1
        args.state.audio_volume += 0.1
      elsif args.state.audio_volume >= 1
        args.state.audio_volume = 1
      end
      args.state.menu_option_click_cooldown += 10
    end
    if args.inputs.left and args.state.menu_option_click_cooldown <= 0
      if args.state.audio_volume > 0
        args.state.audio_volume -= 0.1
      elsif args.state.audio_volume <= 0
        args.state.audio_volume = 0
      end
      args.state.menu_option_click_cooldown += 10
    end
    if args.inputs.mouse.intersect_rect?(args.state.audio_volume_down_button)
      args.state.audio_volume_button_outline = [x: 580, y: 446, w: 64, h: 64, path: 'sprites/menu-option-outline.png']
      if args.inputs.mouse.click
        if args.state.audio_volume > 0
          args.state.audio_volume -= 0.1
        elsif args.state.audio_volume <= 0
          args.state.audio_volume = 0
        end
        args.state.menu_option_click_cooldown += 10
      end
    end
    if args.inputs.mouse.intersect_rect?(args.state.audio_volume_up_button)
      args.state.audio_volume_button_outline = [x: 690, y: 446, w: 64, h: 64, path: 'sprites/menu-option-outline.png']
      if args.inputs.mouse.click
        if args.state.audio_volume < 1
          args.state.audio_volume += 0.1
        elsif args.state.audio_volume >= 1
          args.state.audio_volume = 1
        end
        args.state.menu_option_click_cooldown += 10
      end
    end
  end
  if args.state.menu_option == 3
    args.state.button_outline = [x: 160, y: 96, w: 220, h: 64, path: 'sprites/menu-option-outline.png']
    if args.inputs.keyboard.enter or args.inputs.mouse.click or args.inputs.controller_one.key_down.a and args.state.menu_option_click_cooldown <= 0
      args.state.next_scene = :menu_scene
      args.state.menu_option_click_cooldown += 10
    end
  end

  args.outputs.background_color = [255, 255, 255]
  args.outputs.labels << {x: 180, y: 600, text: "CPU Attack Warning:", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
  if args.state.cpu_attack_warning == true
    args.outputs.labels << {x: 600, y: 600, text: "Enabled", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
  end
  if args.state.cpu_attack_warning == false
    args.outputs.labels << {x: 600, y: 600, text: "Disabled", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
  end
  args.outputs.labels << {x: 180, y: 500, text: "Audio Volume:", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
  args.outputs.labels << {x: 600, y: 500, text: "< #{(args.state.audio_volume)} >", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
  args.outputs.labels << {x: 180, y: 150, text: "Main Menu.", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
  args.outputs.primitives << args.state.button_outline
  args.outputs.primitives << args.state.audio_volume_button_outline
end