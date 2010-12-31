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

World.instance.screen = screen
World.instance.font = font

info = World.instance.info

mtime = File.mtime(src_path)
load src_path

K = SDL::Key
while true
  begin
    if (mt = File.mtime(src_path)) != mtime
      World.instance.clear
      begin
        load src_path
      rescue Exception => e
        p e
        World.instance.clear
      end
      mtime = mt
    end
  rescue Errno::ENOENT
  end

  while event = SDL::Event.poll
    case event
    when SDL::Event::MouseButtonUp
      World.instance.mouse_clicked
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

  World.instance.render

  screen.flip

  sleep 0.017
end
