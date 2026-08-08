def tick_pause_scene args
  args.outputs.labels << [x: 580, y: 460, text: "Paused.", size_enum: 10, a: 255, r: 0, g: 0, b: 0]

  args.outputs.background_color = [255, 255, 255]

  if args.inputs.keyboard.key_down.p or args.inputs.controller_one.key_down.start or args.inputs.controller_two.key_down.start
    args.state.next_scene = :game_scene
  end
end