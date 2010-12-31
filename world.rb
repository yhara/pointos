require 'singleton'
require 'complex' # for Ruby 1.8

module Pointos
  class World
    include Singleton

    Info = Struct.new(:screen)
    BLACK   = [0,0,0]
    RED     = [255,0,0]
    GREEN   = [0,255,0]
    BLUE    = [0,0,255]
    YELLOW  = [255,255,0]
    CYAN    = [0,255,255]
    MAGENTA = [255,0,255]
    WHITE   = [255,255,255]

    def initialize
      @things = []
      @scale_value = 100
    end

    def screen=(screen)
      @center_x = screen.w / 2
      @center_y = screen.h / 2
      @info = Info.new(screen)
    end

    attr_accessor :center_x, :center_y, :scale_value

    def add(thing)
      @things << thing
    end

    def remove(thing)
      @things.delete_if{|t| t.equal?(thing)}
    end

    def scale(l)
      l * @scale_value
    end

    def render
      @things.each{|thing| thing.render(@info) }
    end
  end

  class Thing
    def self.new!(*args)
      thing = new(*args)
      World.instance.add(thing)
      thing
    end

    def remove
      World.instance.remove(self)
    end

    def render(info)
      # abstract
    end
  end

  class Background < Thing
    def render(i)
      s = i.screen
      s.fill_rect(0, 0, s.w, s.h, World::BLACK)
    end
  end
  Background.new!

  class Axes < Thing
    def initialize
      @color = World::WHITE
    end

    def render(i)
      x = World.instance.center_x
      y = World.instance.center_y
      i.screen.draw_line(0, y, i.screen.w, y, @color)
      i.screen.draw_line(x, 0, x, i.screen.h, @color)
    end
  end
  Axes.new!

  class Point < Thing
    def initialize(c, name="")
      @c, @name = c, name
      @color = World::YELLOW
    end
    attr_reader :c

    def x
      World.instance.center_x + (World.instance.scale(@c.real))
    end

    def y
      World.instance.center_y - (World.instance.scale(@c.imag))
    end

    def render(i)
      i.screen.draw_circle(self.x, self.y, 1, @color)
    end
  end

  class Line < Thing
    def initialize(from, to)
      @from, @to = from, to
      @color = World::YELLOW
    end
    attr_reader :from, :to

    def render(i)
      i.screen.draw_line(@from.x, @from.y, @to.x, @to.y, @color)
    end
  end

  class Circle < Thing
    def initialize(center, radius)
      @center, @radius = center, radius
      @color = World::YELLOW
    end
    attr_reader :center, :radius
    alias c center
    alias r radius

    def render(i)
      i.screen.draw_circle(@center.x, @center.y,
                           World.instance.scale(@radius), @color)
    end
  end
end
