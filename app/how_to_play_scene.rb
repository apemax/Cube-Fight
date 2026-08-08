def tick_how_to_play_scene args
  args.state.back_to_menu_button ||= {x: 430, y: 46, w: 384, h: 64}
  args.state.back_to_menu_button_outline ||= [x: 1300, y: 800, w: 384, h: 64, path: 'sprites/menu-option-outline.png']

  if args.state.menu_option_click_cooldown > 0
    args.state.menu_option_click_cooldown -= 1
  end

  args.outputs.background_color = [255, 255, 255]
  args.outputs.labels << {x: 460, y: 680, text: "Controls:", size_enum: 30, a: 255, r: 0, g: 0, b: 0}
  args.outputs.labels << {x: 520, y: 570, text: "Player One:", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
  args.outputs.labels << {x: 330, y: 500, text: "w, s, a, d or Left Analog Stick, DPad = Movement", size_enum: 3, a: 255, r: 0, g: 0, b: 0}
  args.outputs.labels << {x: 410, y: 450, text: "g, h or X, Y = Punch with each fist", size_enum: 3, a: 255, r: 0, g: 0, b: 0}
  args.outputs.labels << {x: 500, y: 400, text: "space or L1 = Dodge", size_enum: 3, a: 255, r: 0, g: 0, b: 0}

  args.outputs.labels << {x: 520, y: 350, text: "Player Two:", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
  args.outputs.labels << {x: 330, y: 280, text: "Arrow keys or Left Analog Stick, DPad = Movement", size_enum: 3, a: 255, r: 0, g: 0, b: 0}
  args.outputs.labels << {x: 410, y: 230, text: "[, ] or X, Y = Punch with each fist", size_enum: 3, a: 255, r: 0, g: 0, b: 0}
  args.outputs.labels << {x: 470, y: 180, text: "Right Shift or L1 = Dodge", size_enum: 3, a: 255, r: 0, g: 0, b: 0}
  
  args.outputs.labels << {x: 450, y: 100, text: "Back to main menu", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
  args.outputs.primitives << args.state.back_to_menu_button_outline

  if args.inputs.keyboard.escape or args.inputs.keyboard.enter or args.inputs.controller_one.key_down.b and args.state.menu_option_click_cooldown <= 0
    args.state.next_scene = :menu_scene
    args.state.menu_option_click_cooldown += 10
  end

  if args.inputs.mouse.intersect_rect?(args.state.back_to_menu_button) and args.state.menu_option_click_cooldown <= 0
    args.state.back_to_menu_button_outline = [x: 430, y: 46, w: 384, h: 64, path: 'sprites/menu-option-outline.png']
    if args.inputs.keyboard.enter or args.inputs.mouse.click or args.inputs.controller_one.key_down.a
      args.state.next_scene = :menu_scene
      args.state.menu_option_click_cooldown += 10
    end
  end
end