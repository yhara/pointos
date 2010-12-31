require './pointos.rb'
include Pointos

if ARGV.size == 0
  puts "usage: #$0 src.rb"
  exit
else
  src_path = ARGV[0]
end

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
      when 4 then world.wheel(-1)
      when 5 then world.wheel(+1)
      end
    when SDL::Event::MouseButtonUp
      if event.button == 1
        world.mouse_clicked
      end
    when SDL::Event::Quit
      exit
    when SDL::Event::KeyDown
      case event.sym
      when K::ESCAPE, K::Q
        exit
      when K::P then info.mode = :pencil
      when K::E then info.mode = :eraser
      when K::C then info.show_coords = !info.show_coords
      end
    end
  end

  world.render

  screen.flip

  sleep 0.017
end
