require 'hashie/mash'
require 'singleton'
require 'complex' # for Ruby 1.8

module Pointos
  BLACK   = [0,0,0]
  RED     = [255,0,0]
  GREEN   = [0,255,0]
  BLUE    = [0,0,255]
  YELLOW  = [255,255,0]
  CYAN    = [0,255,255]
  MAGENTA = [255,0,255]
  WHITE   = [255,255,255]

  class World
    include Singleton

    def initialize
      @internals = [Background.new, Axes.new]
      @things = []
      @scale_value = 100
      @mode = :pencil
      @info = Hashie::Mash.new(
        :mode => :pencil,
        :show_coords => true
      )
    end

    def screen=(screen)
      @center_x = screen.w / 2
      @center_y = screen.h / 2
      @info.screen = screen
    end

    attr_reader :info

    def font=(font)
      @info.font = font
    end

    attr_accessor :center_x, :center_y, :scale_value

    def add(thing)
      @things << thing
    end

    def remove(thing)
      @things.delete_if{|t| t.equal?(thing)}
    end

    def clear
      @things.clear
    end

    def scale(l)
      l * @scale_value
    end

    def to_complex(x, y)
      Complex.rectangular((x - @center_x) / @scale_value.to_f,
                          -(y - @center_y) / @scale_value.to_f)
    end

    def render
      (@internals + @things).each{|thing| thing.render(@info) }
    end

    def mouse_clicked
      @point_name ||= "A"
      x, y, = SDL::Mouse.state
      case @info.mode
      when :pencil
        Point.new!(self.to_complex(x, y), @point_name)
        @point_name = @point_name.succ
      when :eraser
        # TODO
      end
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
      s.fill_rect(0, 0, s.w, s.h, Pointos::BLACK)
    end
  end

  class Axes < Thing
    def initialize
      @color = Pointos::WHITE
    end

    def render(i)
      x = World.instance.center_x
      y = World.instance.center_y
      i.screen.draw_line(0, y, i.screen.w, y, @color)
      i.screen.draw_line(x, 0, x, i.screen.h, @color)
    end
  end

  class Point < Thing
    def initialize(c, name="")
      @c, @name = c, name
      @color = Pointos::YELLOW
    end
    attr_accessor :c

    def x
      World.instance.center_x + (World.instance.scale(@c.real))
    end

    def y
      World.instance.center_y - (World.instance.scale(@c.imag))
    end

    def render(i)
      i.screen.draw_circle(self.x, self.y, 1, @color)
      if i.show_coords
        str = format("#{@name} (%.2f+%.2fi)", @c.real, @c.imag)
      else
        str = @name
      end
      i.font.textout(i.screen, str, self.x + 3, self.y + 3)
    end
  end

  class Line < Thing
    def initialize(from, to)
      @from, @to = from, to
      @color = Pointos::YELLOW
    end
    attr_reader :from, :to

    def render(i)
      i.screen.draw_line(@from.x, @from.y, @to.x, @to.y, @color)
    end
  end

  class Circle < Thing
    def initialize(center, radius)
      @center, @radius = center, radius
      @color = Pointos::YELLOW
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
