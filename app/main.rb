require 'app/defaults.rb'
require 'app/player_one_input.rb'
require 'app/cpu_one_input.rb'
require 'app/collision_detection.rb'

def boot args
  args.state = {}
  args.state.cpu_attack_warning ||= true
  args.state.menu_option_click_cooldown ||= 0
end

def tick args
  args.state.current_scene ||= :menu_scene

  current_scene = args.state.current_scene

  case current_scene
  when :menu_scene
    tick_menu_scene args
  when :how_to_play_scene
    tick_how_to_play_scene args
  when :options_scene
    tick_options_scene args
  when :game_scene
    tick_game_scene args
  when :game_over_scene
    tick_game_over_scene args
  when :pause_scene
    tick_pause_scene args
  end

  if args.state.current_scene != current_scene
    raise "Scene was changed incorrectly. Set args.state.next_scene to change scenes."
  end

  if args.state.next_scene
    args.state.current_scene = args.state.next_scene
    args.state.next_scene = nil
  end
end

def tick_menu_scene args
  args.state.menu_option_player_vs_cpu ||= {x: 180, y: 416, w: 384, h: 64}
  args.state.menu_option_how_to_play ||= {x: 180, y: 316, w: 384, h: 64}
  args.state.menu_option_options ||= {x: 180, y: 216, w: 384, h: 64}
  args.state.menu_option_exit ||= {x: 180, y: 116, w: 384, h: 64}
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
  if args.inputs.mouse.intersect_rect?(args.state.menu_option_how_to_play)
    args.state.menu_option_main = 2
  end
  if args.inputs.mouse.intersect_rect?(args.state.menu_option_options)
    args.state.menu_option_main = 3
  end
  if args.inputs.mouse.intersect_rect?(args.state.menu_option_exit)
    args.state.menu_option_main = 4
  end

  args.outputs.background_color = [255, 255, 255]
  args.outputs.labels << {x: 180, y: 620, text: "20 Second Cube Fight", size_enum: 40, a: 255, r: 0, g: 0, b: 0}
  args.outputs.labels << {x: 180, y: 480, text: "Player VS CPU", size_enum: 20, a: 255, r: 0, g: 0, b: 0}
  args.outputs.labels << {x: 180, y: 380, text: "How to Play", size_enum: 20, a: 255, r: 0, g: 0, b: 0}
  args.outputs.labels << {x: 180, y: 280, text: "Options", size_enum: 20, a: 255, r: 0, g: 0, b: 0}
  args.outputs.labels << {x: 180, y: 180, text: "Exit", size_enum: 20, a: 255, r: 0, g: 0, b: 0}
  args.outputs.primitives << args.state.menu_option_outline

  if args.state.menu_option_main == 1
    args.state.menu_option_outline = [x: 180, y: 416, w: 256, h: 64, path: 'sprites/menu-option-outline.png']
    if args.inputs.keyboard.enter or args.inputs.mouse.click
      args.state.next_scene = :game_scene
      args.audio[:starting_bell] = {input: "sounds/blastwave_fx_boxingbellring_s08sp.136.mp3", gain: 0.2}
    end
  end
  if args.state.menu_option_main == 2
    args.state.menu_option_outline = [x: 180, y: 316, w: 256, h: 64, path: 'sprites/menu-option-outline.png']
    if args.inputs.keyboard.enter or args.inputs.mouse.click
      args.state.next_scene = :how_to_play_scene
    end
  end
  if args.state.menu_option_main == 3
    args.state.menu_option_outline = [x: 180, y: 216, w: 256, h: 64, path: 'sprites/menu-option-outline.png']
    if args.inputs.keyboard.enter or args.inputs.mouse.click and args.state.menu_option_click_cooldown <= 0
      args.state.next_scene = :options_scene
      args.state.menu_option_click_cooldown += 10
    end
  end
  if args.state.menu_option_main == 4
    args.state.menu_option_outline = [x: 180, y: 116, w: 256, h: 64, path: 'sprites/menu-option-outline.png']
    if args.inputs.keyboard.enter or args.inputs.mouse.click
      GTK.request_quit
    end
  end
end

def tick_how_to_play_scene args
  args.state.back_to_menu_button ||= {x: 430, y: 46, w: 384, h: 64}
  args.state.back_to_menu_button_outline ||= [x: 1300, y: 800, w: 384, h: 64, path: 'sprites/menu-option-outline.png']

  args.outputs.background_color = [255, 255, 255]
  args.outputs.labels << {x: 180, y: 620, text: "20 Second Cube Fight", size_enum: 40, a: 255, r: 0, g: 0, b: 0}
  args.outputs.labels << {x: 520, y: 500, text: "Controls:", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
  args.outputs.labels << {x: 150, y: 450, text: "w, s, a, d or arrow keys = Move up, down, left, right.", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
  args.outputs.labels << {x: 350, y: 400, text: "k, l = Punch with each fist.", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
  args.outputs.labels << {x: 200, y: 350, text: "space = Dodge in the direction you are moving.", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
  args.outputs.labels << {x: 450, y: 250, text: "Hit your opponent.", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
  args.outputs.labels << {x: 450, y: 200, text: "Avoid getting hit.", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
  args.outputs.labels << {x: 450, y: 100, text: "Back to main menu.", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
  args.outputs.primitives << args.state.back_to_menu_button_outline

  if args.inputs.keyboard.escape
    args.state.next_scene = :menu_scene
  end

  if args.inputs.mouse.intersect_rect?(args.state.back_to_menu_button)
    args.state.back_to_menu_button_outline = [x: 430, y: 46, w: 384, h: 64, path: 'sprites/menu-option-outline.png']
    if args.inputs.keyboard.enter or args.inputs.mouse.click
      args.state.next_scene = :menu_scene
    end
  end
end

def tick_options_scene args
  args.state.cpu_attack_warning_button ||= {x: 180, y: 546, w: 384, h: 64}
  args.state.back_to_menu_button ||= {x: 180, y: 96, w: 384, h: 64}
  args.state.button_outline ||= [x: 1300, y: 800, w: 384, h: 64, path: 'sprites/menu-option-outline.png']
  args.state.menu_option ||= 1
  args.state.menu_option_cooldown ||= 0

  if args.inputs.up and args.state.menu_option_cooldown <= 0 and args.state.menu_option >= 2
    args.state.menu_option_cooldown += 10
    args.state.menu_option -= 1
  end
  if args.inputs.down and args.state.menu_option_cooldown <= 0 and args.state.menu_option <= 1
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
  if args.inputs.mouse.intersect_rect?(args.state.back_to_menu_button)
    args.state.menu_option = 2
  end

  if args.state.menu_option == 1
    args.state.button_outline = [x: 160, y: 546, w: 390, h: 64, path: 'sprites/menu-option-outline.png']
    if args.inputs.keyboard.enter or args.inputs.mouse.click and args.state.menu_option_click_cooldown <= 0
      if args.state.cpu_attack_warning == true
        args.state.cpu_attack_warning = false
      elsif args.state.cpu_attack_warning == false
        args.state.cpu_attack_warning = true
      end
      args.state.menu_option_click_cooldown += 10
    end
  end
  if args.state.menu_option == 2
    args.state.button_outline = [x: 160, y: 96, w: 220, h: 64, path: 'sprites/menu-option-outline.png']
    if args.inputs.keyboard.enter or args.inputs.mouse.click and args.state.menu_option_click_cooldown <= 0
      args.state.next_scene = :menu_scene
      args.state.menu_option_click_cooldown += 10
    end
  end

  args.outputs.background_color = [255, 255, 255]
  args.outputs.labels << {x: 180, y: 600, text: "CPU Attack Warning: ", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
  if args.state.cpu_attack_warning == true
    args.outputs.labels << {x: 600, y: 600, text: "Enabled", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
  end
  if args.state.cpu_attack_warning == false
    args.outputs.labels << {x: 600, y: 600, text: "Disabled", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
  end
  args.outputs.labels << {x: 180, y: 150, text: "Main Menu.", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
  args.outputs.primitives << args.state.button_outline
end

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

  if args.state.player_one_fist_left[:cooldown] > 0
    args.state.player_one_fist_left[:cooldown] -= 1
  end
  if args.state.player_one_fist_right[:cooldown] > 0
    args.state.player_one_fist_right[:cooldown] -= 1
  end

  if args.state.player_one[:cooldown] > 0
    args.state.player_one[:cooldown] -= 1
  end

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

  player_one_input args

  cpu_one_input args

  update_hit_effects args

  collision_detection args

  args.outputs.background_color = [255, 255, 255]
  if args.state.cpu_attack_warning == true
    args.outputs.primitives << args.state.cpu_one_attack_zone
  end
  args.outputs.primitives << args.state.player_one
  args.outputs.primitives << args.state.player_one_health_bar
  args.outputs.primitives << args.state.cpu_one
  args.outputs.primitives << args.state.cpu_one_health_bar
  args.outputs.primitives << args.state.player_one_fist_right
  args.outputs.primitives << args.state.player_one_fist_left
  args.outputs.primitives << args.state.cpu_one_fist_left
  args.outputs.primitives << args.state.cpu_one_fist_right
  args.outputs.primitives << args.state.hit_effects
  args.outputs.primitives << args.state.health_bar_outline_right
  args.outputs.primitives << args.state.health_bar_outline_left
  args.outputs.labels << {x: 50, y: 660, text: "Player One", size_enum: 5, a: 255, r: 0, g: 0, b: 0}
  args.outputs.labels << {x: 1050, y: 660, text: "CPU One", size_enum: 5, a: 255, r: 0, g: 0, b: 0}
  args.outputs.labels << {x: 560, y: 700, text: "Time: #{(args.state.match_timer)}", size_enum: 10, a: 255, r: 0, g: 0, b: 0}

  if args.state.match_timer <= 0
    args.state.match_time_out = true
    args.state.next_scene = :game_over_scene
  end
  if args.state.player_one[:health] <= 0 or args.state.cpu_one[:health] <= 0
    args.state.match_ko = true
    args.state.next_scene = :game_over_scene
  end
end

def tick_game_over_scene args
  args.state.back_to_menu_button ||= {x: 500, y: 96, w: 384, h: 64}
  args.state.play_again_button ||= {x: 180, y: 96, w: 384, h: 64}
  args.state.back_to_menu_button_outline ||= [x: 1300, y: 800, w: 384, h: 64, path: 'sprites/menu-option-outline.png']
  args.state.menu_option_game_over ||= 1
  args.state.menu_option_cooldown ||= 0

  if args.inputs.left and args.state.menu_option_cooldown <= 0 and args.state.menu_option_game_over >= 2
    args.state.menu_option_cooldown += 10
    args.state.menu_option_game_over -= 1
  end
  if args.inputs.right and args.state.menu_option_cooldown <= 0 and args.state.menu_option_game_over <= 2
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
    args.outputs.labels << {x: 510, y: 500, text: "Player VS CPU", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
    args.outputs.labels << {x: 250, y: 450, text: "Hits taken:", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
    args.outputs.labels << {x: 550, y: 450, text: "#{(args.state.player_one[:hits_taken])}", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
    args.outputs.labels << {x: 710, y: 450, text: "#{(args.state.cpu_one[:hits_taken])}", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
    args.outputs.labels << {x: 231, y: 400, text: "Health left:", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
    args.outputs.labels << {x: 550, y: 400, text: "#{(args.state.player_one[:health])}", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
    args.outputs.labels << {x: 710, y: 400, text: "#{(args.state.cpu_one[:health])}", size_enum: 10, a: 255, r: 0, g: 0, b: 0}

    if args.state.cpu_one[:health] < args.state.player_one[:health]
      args.outputs.labels << {x: 500, y: 300, text: "Player Wins!", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
    end
    if args.state.player_one[:health] < args.state.cpu_one[:health]
      args.outputs.labels << {x: 540, y: 300, text: "CPU Wins!", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
    end
    if args.state.cpu_one[:health] == args.state.player_one[:health]
      args.outputs.labels << {x: 500, y: 300, text: "Tie!", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
    end

    args.outputs.labels << {x: 180, y: 150, text: "Play again.", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
    args.outputs.labels << {x: 500, y: 150, text: "Main Menu.", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
  end

  if args.state.match_ko == true
    args.outputs.labels << {x: 600, y: 600, text: "KO!", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
    args.outputs.labels << {x: 510, y: 500, text: "Player VS CPU", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
    args.outputs.labels << {x: 250, y: 450, text: "Hits taken:", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
    args.outputs.labels << {x: 550, y: 450, text: "#{(args.state.player_one[:hits_taken])}", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
    args.outputs.labels << {x: 710, y: 450, text: "#{(args.state.cpu_one[:hits_taken])}", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
    args.outputs.labels << {x: 231, y: 400, text: "Health left:", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
    args.outputs.labels << {x: 550, y: 400, text: "#{(args.state.player_one[:health])}", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
    args.outputs.labels << {x: 710, y: 400, text: "#{(args.state.cpu_one[:health])}", size_enum: 10, a: 255, r: 0, g: 0, b: 0}

    if args.state.cpu_one[:health] <= 0
      args.outputs.labels << {x: 500, y: 300, text: "Player Wins!", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
    end
    if args.state.player_one[:health] <= 0
      args.outputs.labels << {x: 540, y: 300, text: "CPU Wins!", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
    end
    if args.state.cpu_one[:health] == args.state.player_one[:health]
      args.outputs.labels << {x: 500, y: 300, text: "Tie!", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
    end

    args.outputs.labels << {x: 180, y: 150, text: "Play again.", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
    args.outputs.labels << {x: 500, y: 150, text: "Main Menu.", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
  end

  args.outputs.primitives << args.state.back_to_menu_button_outline

  if args.state.menu_option_game_over == 1
    args.state.back_to_menu_button_outline = [x: 160, y: 96, w: 256, h: 64, path: 'sprites/menu-option-outline.png']
    if args.inputs.keyboard.enter or args.inputs.mouse.click
      args.state.next_scene = :game_scene
      args.audio[:starting_bell] = {input: "sounds/blastwave_fx_boxingbellring_s08sp.136.mp3", gain: 0.2}
      reset_defaults args
    end
  end
  if args.state.menu_option_game_over == 2
    args.state.back_to_menu_button_outline = [x: 480, y: 96, w: 256, h: 64, path: 'sprites/menu-option-outline.png']
    if args.inputs.keyboard.enter or args.inputs.mouse.click
      args.state.next_scene = :menu_scene
      reset_defaults args
    end
  end
end

def tick_pause_scene args
  args.outputs.labels << [x: 580, y: 460, text: "Paused.", size_enum: 10, a: 255, r: 0, g: 0, b: 0]

  args.outputs.background_color = [255, 255, 255]

  if args.inputs.keyboard.key_down.p or args.inputs.controller_one.key_down.start
    args.state.next_scene = :game_scene
  end
end

def update_hit_effects args
  args.state.hit_effects.each do |hit|
    hit[:age]  += 1
    hit[:path] = "sprites/hit-effect-#{hit[:age].floor}.png"
  end
  args.state.hit_effects = args.state.hit_effects.reject { |hit| hit[:age] >= 10 }
end

def debug args
  args.outputs.debug << args.gtk.framerate_diagnostics_primitives
  args.outputs.labels << [x: 10, y: 80, text: "player_one cooldown: #{(args.state.player_one[:cooldown])}", size_enum: 3, a: 255, r: 0, g: 0, b: 0]
  args.outputs.labels << [x: 10, y: 110, text: "player_one dx: #{(args.state.player_one[:dx])}", size_enum: 3, a: 255, r: 0, g: 0, b: 0]
  args.outputs.labels << [x: 10, y: 140, text: "player_one dy: #{(args.state.player_one[:dy])}", size_enum: 3, a: 255, r: 0, g: 0, b: 0]
  args.outputs.labels << [x: 10, y: 170, text: "player_one fist dy: #{(args.state.player_one_fist_right[:dx])}", size_enum: 3, a: 255, r: 0, g: 0, b: 0]
  args.outputs.labels << [x: 10, y: 200, text: "cpu one fist_right dx: #{(args.state.cpu_one_fist_right[:dx])}", size_enum: 3, a: 255, r: 0, g: 0, b: 0]
  args.outputs.labels << [x: 10, y: 230, text: "cpu one fist_right timer: #{(args.state.cpu_one_fist_right_timer_started)}", size_enum: 3, a: 255, r: 0, g: 0, b: 0]
  args.outputs.labels << [x: 10, y: 260, text: "cpu_attack_warning: #{(args.state.cpu_attack_warning)}", size_enum: 3, a: 255, r: 0, g: 0, b: 0]
end