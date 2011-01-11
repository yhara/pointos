require 'pointos'
include Pointos

src_path = caller.last[/[^:]*/]

require 'sdl'

SDL.init( SDL::INIT_VIDEO )

screen = SDL::Screen.open(640,480,16,SDL::SWSURFACE)
font = SDL::BMFont.open("font.bmp",SDL::BMFont::TRANSPARENT)

world = World.instance

world.screen = screen
world.font = font

info = world.info

mtime = File.mtime(src_path)
load src_path

drag_start = [nil, nil]
K = SDL::Key
while true
  begin
    if (mt = File.mtime(src_path)) != mtime
      world.clear
      begin
        load src_path
      rescue Exception => e
        p e
        world.clear
      end
      mtime = mt
    end
  rescue Errno::ENOENT
  end

  while event = SDL::Event.poll
    case event
    when SDL::Event::MouseButtonDown
      case event.button
      when 1 
        x, y, = SDL::Mouse.state
        drag_start = [x, y]
      when 4 then world.wheel(-1)
      when 5 then world.wheel(+1)
      end
    when SDL::Event::MouseMotion
      x, y, btn1, = SDL::Mouse.state
      if btn1
        world.dragged(event.xrel, event.yrel)
      end
    when SDL::Event::MouseButtonUp
      if event.button == 1
        x, y, = SDL::Mouse.state
        if drag_start == [x, y]
          world.mouse_clicked
        end
      end
    when SDL::Event::Quit
      exit
    when SDL::Event::KeyDown
      case event.sym
      when K::ESCAPE, K::Q
        exit
      when K::P then info.mode = :pencil
      #when K::E then info.mode = :eraser
      when K::C then info.show_coords = !info.show_coords
      end
    end
  end

  world.render

  screen.flip

  sleep 0.017 # about 60 fps
end
