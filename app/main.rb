require 'app/menu_scene.rb'
require 'app/how_to_play_scene.rb'
require 'app/options_scene.rb'
require 'app/game_scene.rb'
require 'app/game_over_scene.rb'
require 'app/pause_scene.rb'
require 'app/defaults.rb'
require 'app/player_one_input.rb'
require 'app/player_two_input.rb'
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

def update_hit_effects args
  args.state.hit_effects.each do |hit|
    hit[:age]  += 1
    hit[:path] = "sprites/hit-effect-#{hit[:age].floor}.png"
  end
  args.state.hit_effects = args.state.hit_effects.reject { |hit| hit[:age] >= 10 }
end

def debug args
  args.outputs.debug << args.gtk.framerate_diagnostics_primitives
  args.outputs.labels << [x: 10, y: 30, text: "player_one cooldown: #{(args.state.player_one[:cooldown])}", size_enum: 1, a: 255, r: 0, g: 0, b: 0]
  args.outputs.labels << [x: 10, y: 55, text: "player_one dx: #{(args.state.player_one[:dx])}", size_enum: 1, a: 255, r: 0, g: 0, b: 0]
  args.outputs.labels << [x: 10, y: 80, text: "player_one dy: #{(args.state.player_one[:dy])}", size_enum: 1, a: 255, r: 0, g: 0, b: 0]
  args.outputs.labels << [x: 10, y: 105, text: "player_one fist dy: #{(args.state.player_one_fist_right[:dx])}", size_enum: 1, a: 255, r: 0, g: 0, b: 0]
  args.outputs.labels << [x: 10, y: 130, text: "cpu one fist_right dx: #{(args.state.cpu_one_fist_right[:dx])}", size_enum: 1, a: 255, r: 0, g: 0, b: 0]
  args.outputs.labels << [x: 10, y: 155, text: "cpu one fist_right timer: #{(args.state.cpu_one_fist_right_timer_started)}", size_enum: 1, a: 255, r: 0, g: 0, b: 0]
  args.outputs.labels << [x: 10, y: 180, text: "cpu_attack_warning: #{(args.state.cpu_attack_warning)}", size_enum: 1, a: 255, r: 0, g: 0, b: 0]
  args.outputs.labels << [x: 10, y: 205, text: "cpu_one_enabled: #{(args.state.cpu_one_enabled)}", size_enum: 1, a: 255, r: 0, g: 0, b: 0]
  args.outputs.labels << [x: 10, y: 230, text: "player_one_enabled: #{(args.state.player_one_enabled)}", size_enum: 1, a: 255, r: 0, g: 0, b: 0]
  args.outputs.labels << [x: 10, y: 255, text: "player_two_enabled: #{(args.state.player_two_enabled)}", size_enum: 1, a: 255, r: 0, g: 0, b: 0]
end