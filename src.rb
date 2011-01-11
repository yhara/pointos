require 'pointos/main'

class Complex
  def normalized
    self / self.abs
  end
end

include Math

O = Point(0.i)

=begin
$BJ#AG?t(B (Complex)

* class Point ; attr_accessor :x, :y
* 2$B$D$N<B?t$NAH(B
* $B$=$lJ#AG?t$G(B
    1 + 2i
    ~   ~~
  $B<BIt(B  $B5uIt(B
 (real) (imag)

 c.real c.imag

* i = $B5u?tC10L(B (i * i = -1)
=end

=begin
$B%,%&%9J?LL(B

* $BJ#AG?t(B > $B<B?t(B > $BM-M}?t(B > $B@0?t(B > $B<+A3?t(B
         | $B?tD>@~>e(B
=end

=begin
Ruby$B$K$*$1$kJ#AG?t(B

* 1.9$B$G$OAH$_9~$_(B(1.8$B$G$O(Brequire 'complex')
* $B%j%F%i%k!'(BInteger#i
  1 + 2.i
=end

=begin
$BJ#AG?t!_@0?t(B

* $B@0?t$r3]$1$k$H86E@$+$i$N5wN%$,(Bn$BG\$K$J$k(B

A1 = Point(1)
B1 = Point(1 * 2)
A2 = Point(1+1.i)
B2 = Point((1+1.i) * 2)
A3 = Point(0.5+1.i)
B3 = Point((0.5+1.i) * 3)
#I = Point(1.i)  # i 
=end

=begin
$BJ#AG?t!_J#AG?t(B(1)

* $BC10L1_>e$NE@$r$+$1$k$3$H$G2sE>$,$G$-$k$h(B

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
$BJ#AG?t!_J#AG?t(B(1)

* $BJ#AG?tF1;N$N$+$1;;!a3HBg!\2sE>(B

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
$BE@$HD>@~$N5wN%(B

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
$BE@$rD>@~$NH?BPB&$K(B

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
$B1_$HD>@~$N8rE@(B

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
