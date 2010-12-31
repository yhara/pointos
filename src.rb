class Complex
  def normalized
    self / self.abs
  end
end

include Math
World.instance.scale_value = 50

O = Point(0.i)

=begin
複素数のかけ算(1) magnitude

* 整数を掛けると原点からの距離がn倍になる
=end

=begin
複素数のかけ算(2) angle

* 単位円上の点をかけることで回転ができるよ

p1 = Point.new!(Complex.polar(2, PI/6), "p1")
Circle(O, p1.c.magnitude)

p2 = Point.new!(Complex.polar(1, PI/6), "p2")
Line(O, p2)

p3 = Point.new!(p1.c * p2.c * p2.c * p2.c * p2.c * p2.c, "p3")
=end


=begin
複素数のかけ算(3)

* 複素数同士のかけ算＝拡大＋回転
=end

=begin
点と直線の距離

A = Point(1.2+2.4.i)
B = Point(-1.5+2.5.i)
C = Point(1.8+3.7.i)
Line(B, C)

B2 = Point(B - A)
C2 = Point(C - A)
Line(B2, C2)

Diff = Point((C - B)/(C-B).abs)
MDiff = Point(Diff.real - Diff.imag.i)
Line(O, MDiff)

B3 = Point(B2 * MDiff)
C3 = Point(C2 * MDiff)
Line(B3, C3, RED)
=end


=begin
点を直線の反対側に

A = Point(1.1+2.7.i)
B = Point(-1.5+2.5.i)
C = Point(1.8+3.7.i)
Line(B, C)

mdiff = Point(((C - B)/(C - B).abs).conj)

B3 = Point((B - A) * mdiff)
C3 = Point((C - A) * mdiff)
Line(B3, C3, RED)

A3 = Point((B3.imag*2).i)

A4 = Point((A3 / mdiff)+ A)
#Line(A, A4)
=end

=begin
円と直線の交点
=end

A = Point(1.1+2.9.i)
Circle(A, 0.7)
B = Point(-1.5+2.5.i)
C = Point(1.8+3.7.i)
Line(B, C)

rot = (C-B).normalized.conj
B2 = Point((B - A) * rot)
C2 = Point((C - A) * rot)
Line(B2, C2)
Circle(O, 0.7)

#A2 = Point(Complex.polar(0.7, 0.9))
#Line O, A2

#     +---+ A2
#     |  /
# 0.51|?/ 0.7
#     |/
#     +
#     O
#
#cos(angle) = 0.7 / 0.51
angle = acos(B2.imag.abs / 0.7)

A2 = Point(Complex.polar(0.7, angle))
Line O, A2
