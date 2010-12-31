require './world.rb'
include Pointos
require 'sdl'

SDL.init( SDL::INIT_VIDEO )

screen = SDL::Screen.open(640,480,16,SDL::SWSURFACE)
font = SDL::BMFont.open("font.bmp",SDL::BMFont::TRANSPARENT)

World.instance.screen = screen
World.instance.font = font

info = World.instance.info

p1 = Point.new!(Complex.rectangular(1,2), "p1")
c1 = Circle.new!(p1, 1)

K = SDL::Key
while true
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

