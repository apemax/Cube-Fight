require 'app/defaults.rb'
require 'app/player_one_input.rb'
require 'app/cpu_one_input.rb'
require 'app/collision_detection.rb'

def boot args
  args.state = {}
end

def tick args
  args.state.current_scene ||= :menu_scene

  current_scene = args.state.current_scene

  case current_scene
  when :menu_scene
    tick_menu_scene args
  when :how_to_play_scene
    tick_how_to_play_scene args
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
  args.state.menu_option_player_vs_cpu ||= {x: 180, y: 500, w: 256, h: 64}
  args.state.menu_option_how_to_play ||= {x: 180, y: 400, w: 256, h: 64}
  args.state.menu_option_exit ||= {x: 180, y: 300, w: 256, h: 64}
  args.state.menu_option_outline ||= [x: 1300, y: 800, w: 256, h: 64, path: 'sprites/menu-option-outline.png']
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

  args.outputs.labels << [x: 10, y: 80, text: "menu_option: #{(args.state.menu_option)}", size_enum: 3, a: 255, r: 0, g: 0, b: 0]

  args.outputs.background_color = [255, 255, 255]
  args.outputs.labels << {x: 180, y: 620, text: "20 Second Cube Fight", size_enum: 40, a: 255, r: 0, g: 0, b: 0}
  args.outputs.labels << {x: 180, y: 480, text: "Player VS CPU", size_enum: 20, a: 255, r: 0, g: 0, b: 0}
  args.outputs.labels << {x: 180, y: 380, text: "How to Play", size_enum: 20, a: 255, r: 0, g: 0, b: 0}
  args.outputs.labels << {x: 180, y: 280, text: "Exit", size_enum: 20, a: 255, r: 0, g: 0, b: 0}
  args.outputs.primitives << args.state.menu_option_outline

  if args.state.menu_option == 1
    args.state.menu_option_outline = [x: 180, y: 416, w: 256, h: 64, path: 'sprites/menu-option-outline.png']
    if args.inputs.keyboard.enter
      args.state.next_scene = :game_scene
      args.audio[:starting_bell] = {input: "sounds/blastwave_fx_boxingbellring_s08sp.136.mp3", gain: 0.2}
    end
  end
  if args.state.menu_option == 2
    args.state.menu_option_outline = [x: 180, y: 316, w: 256, h: 64, path: 'sprites/menu-option-outline.png']
    if args.inputs.keyboard.enter
      args.state.next_scene = :how_to_play_scene
    end
  end
  if args.state.menu_option == 3
    args.state.menu_option_outline = [x: 180, y: 216, w: 256, h: 64, path: 'sprites/menu-option-outline.png']
    if args.inputs.keyboard.enter
      GTK.request_quit
    end
  end
end

def tick_how_to_play_scene args
  args.outputs.labels << {x: 180, y: 620, text: "20 Second Cube Fight", size_enum: 40, a: 255, r: 0, g: 0, b: 0}
  args.outputs.labels << {x: 520, y: 500, text: "Controls:", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
  args.outputs.labels << {x: 150, y: 450, text: "w, s, a, d or arrow keys = Move up, down, left, right.", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
  args.outputs.labels << {x: 350, y: 400, text: "k, l = Punch with each fist.", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
  args.outputs.labels << {x: 200, y: 350, text: "space = Dodge in the direction you are moving.", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
  args.outputs.labels << {x: 450, y: 250, text: "Hit your opponent.", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
  args.outputs.labels << {x: 450, y: 200, text: "Avoid getting hit.", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
  args.outputs.labels << {x: 200, y: 100, text: "Hit the Escape key to go back to the main menu.", size_enum: 10, a: 255, r: 0, g: 0, b: 0}

  if args.inputs.keyboard.escape
    args.state.next_scene = :menu_scene
  end
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
  args.outputs.primitives << args.state.cpu_one_attack_zone
  args.outputs.primitives << args.state.player_one
  args.outputs.primitives << args.state.cpu_one
  args.outputs.primitives << args.state.player_one_fist_right
  args.outputs.primitives << args.state.player_one_fist_left
  args.outputs.primitives << args.state.cpu_one_fist_left
  args.outputs.primitives << args.state.cpu_one_fist_right
  args.outputs.primitives << args.state.hit_effects
  args.outputs.labels << {x: 550, y: 700, text: "Time: #{(args.state.match_timer)}", size_enum: 10, a: 255, r: 0, g: 0, b: 0}

  if args.state.match_timer <= 0
    args.state.next_scene = :game_over_scene
  end
end

def tick_game_over_scene args
  args.outputs.background_color = [255, 255, 255]
  args.outputs.labels << {x: 550, y: 600, text: "Times up!", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
  args.outputs.labels << {x: 350, y: 500, text: "Successful hits on opponent: #{(args.state.cpu_one[:hits])}", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
  args.outputs.labels << {x: 520, y: 400, text: "Hits taken: #{(args.state.player_one[:hits])}", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
  args.outputs.labels << {x: 350, y: 200, text: "Press the Enter key to try again.", size_enum: 10, a: 255, r: 0, g: 0, b: 0}
  if args.inputs.keyboard.enter
    args.state.next_scene = :game_scene
    args.state.player_one[:x] = 400
    args.state.player_one[:y] = 300
    args.state.player_one[:dx] = 0
    args.state.player_one[:dy] = 0
    args.state.player_one[:cooldown] = 0
    args.state.player_one[:hits] = 0
    args.state.cpu_one[:x] = 800
    args.state.cpu_one[:y] = 300
    args.state.cpu_one[:dx] = 0
    args.state.cpu_one[:dy] = 0
    args.state.cpu_one[:hits] = 0
    args.state.cpu_one_attack_zone[:x] = 736
    args.state.cpu_one_attack_zone[:y] = 236
    args.state.cpu_one_attack_zone[:dx] = 0
    args.state.cpu_one_attack_zone[:dy] = 0
    args.state.time_seconds = 0
    args.state.time_minutes = 0
    args.state.time_frame = 0
    args.state.match_timer = 20
    args.state.cpu_one_move_timer = 0
    args.state.cpu_one_move_direction = 0
    args.state.player_one_fist_right[:x] = 432
    args.state.player_one_fist_right[:y] = 300
    args.state.player_one_fist_right[:dx] = 0
    args.state.player_one_fist_right[:dy] = 0
    args.state.player_one_fist_left[:x] = 432
    args.state.player_one_fist_left[:y] = 332
    args.state.player_one_fist_left[:dx] = 0
    args.state.player_one_fist_left[:dy] = 0
    args.state.cpu_one_fist_right[:x] = 800
    args.state.cpu_one_fist_right[:y] = 300
    args.state.cpu_one_fist_right[:dx] = 0
    args.state.cpu_one_fist_right[:dy] = 0
    args.state.cpu_one_fist_right[:hit_cooldown] = 0
    args.state.cpu_one_fist_right[:cooldown] = 0
    args.state.cpu_one_fist_left[:x] = 800
    args.state.cpu_one_fist_left[:y] = 332
    args.state.cpu_one_fist_left[:dx] = 0
    args.state.cpu_one_fist_left[:dy] = 0
    args.state.cpu_one_fist_left[:hit_cooldown] = 0
    args.state.cpu_one_fist_left[:cooldown] = 0
    args.state.player_one_fist_right_timer= 0
    args.state.player_one_fist_right_timer_started = false
    args.state.player_one_fist_right_forward = 0
    args.state.player_one_fist_right_backward = 0
    args.state.player_one_fist_left_timer = 0
    args.state.player_one_fist_left_timer_started = false
    args.state.player_one_fist_left_forward = 0
    args.state.player_one_fist_left_backward = 0
    args.state.cpu_one_fist_right_timer = 0
    args.state.cpu_one_fist_right_timer_started = false
    args.state.cpu_one_fist_right_forward = 0
    args.state.cpu_one_fist_right_backward = 0
    args.state.cpu_one_fist_left_timer = 0
    args.state.cpu_one_fist_left_timer_started = false
    args.state.cpu_one_fist_left_forward = 0
    args.state.cpu_one_fist_left_backward = 0
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
end