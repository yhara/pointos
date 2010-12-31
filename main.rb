require './world.rb'
include Pointos
require 'sdl'

SDL.init( SDL::INIT_VIDEO )
screen = SDL::Screen.open(640,480,16,SDL::SWSURFACE)
World.instance.screen = screen

p1 = Point.new!(Complex.rectangular(1,2), "p1")
c1 = Circle.new!(p1, 1)

while true
  while event = SDL::Event.poll
    case event
    when SDL::Event::KeyDown, SDL::Event::Quit
      exit
    end
  end

  World.instance.render

  screen.flip

  sleep 0.2
end

