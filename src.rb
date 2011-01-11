require 'pointos/main'

class Complex
  def normalized
    self / self.abs
  end
end

include Math

O = Point(0.i)

=begin
複素数 (Complex)

* class Point ; attr_accessor :x, :y
* 2つの実数の組
* それ複素数で
    1 + 2i
    ~   ~~
  実部  虚部
 (real) (imag)

 c.real c.imag

* i = 虚数単位 (i * i = -1)
=end

=begin
ガウス平面

* 複素数 > 実数 > 有理数 > 整数 > 自然数
         | 数直線上
=end

=begin
Rubyにおける複素数

* 1.9では組み込み(1.8ではrequire 'complex')
* リテラル：Integer#i
  1 + 2.i
=end

=begin
複素数×整数

* 整数を掛けると原点からの距離がn倍になる

A1 = Point(1)
B1 = Point(1 * 2)
A2 = Point(1+1.i)
B2 = Point((1+1.i) * 2)
A3 = Point(0.5+1.i)
B3 = Point((0.5+1.i) * 3)
#I = Point(1.i)  # i 
=end

=begin
複素数×複素数(1)

* 単位円上の点をかけることで回転ができるよ

p1 = Point.new!(Complex.polar(2, PI/6), "p1")
Circle(O, p1.c.magnitude)

p2 = Point.new!(Complex.polar(1, PI/6), "p2")
Line(O, p2)

p3 = Point.new!(p1.c * p2.c * p2.c * p2.c * p2.c * p2.c, "p3")
=end

#A = Point(2)
#B = Point(2 * Complex.polar(1, PI/6))
#C = Point(Complex.polar(1, PI/3))
#D = Point(Complex.polar(1, PI/2))
#E = Point(Complex.polar(1, PI))
#
#Circle(O, 1)
#Circle(O, 2)

=begin
複素数×複素数(1)

* 複素数同士のかけ算＝拡大＋回転

Circle(O, 0.5)
Circle(O, 1)
Circle(O, 1.5)
Circle(O, 3)

A = Point(0.5)
C = Point(Complex.polar(1, PI/3))
I1 = Point(1)

B = Point(A * C)
D = Point(Complex.polar(3, PI/3))
Line(O, D)

E = Point(A * D)
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

A = Point(1.2+2.4.i)
B = Point(-1.5+2.5.i)
C = Point(1.8+3.7.i)
Line(B, C)
=end

#A = Point(1.2+2.6.i)
#B = Point(-1.5+1.0.i)
#C = Point(1.8+3.7.i)
#Line(B, C)
#Circle(O, 1)
#A2 = Point(A - A)
#B2 = Point(B - A)
#C2 = Point(C - A)
#Line(B2, C2)
#
#C_B = Point(C-B)
#C_B_C_B = Point(C_B / C_B.abs)
#
##Diff = Point((C-B)/(C-B).abs)
##MDiff = Point(Diff.real - Diff.imag.i)
#
#B3 = Point((B - A) / C_B_C_B)
#C3 = Point((C - A) / C_B_C_B)
#Line(O, C_B_C_B)
#Line(B3, C3)
#A3 = Point(0 + B3.imag.i)
#
#A4 = Point((A3 * C_B_C_B)+A)
#Line(A, A4)

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
angle = asin(B2.imag.abs / 0.7)

A2 = Point(Complex.polar(0.7, angle))
Line O, A2

A3 = Point((A2 / rot) + A)
A4 = Point(( (-A2.real+A2.imag.i) / rot) + A)
=end
