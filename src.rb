class Complex
  def normalized
    self / self.abs
  end
end

include Math
World.instance.scale_value = 50

O = Point(0.i)

=begin
$BJ#AG?t$N$+$1;;(B(1) magnitude

* $B@0?t$r3]$1$k$H86E@$+$i$N5wN%$,(Bn$BG\$K$J$k(B
=end

=begin
$BJ#AG?t$N$+$1;;(B(2) angle

* $BC10L1_>e$NE@$r$+$1$k$3$H$G2sE>$,$G$-$k$h(B

p1 = Point.new!(Complex.polar(2, PI/6), "p1")
Circle(O, p1.c.magnitude)

p2 = Point.new!(Complex.polar(1, PI/6), "p2")
Line(O, p2)

p3 = Point.new!(p1.c * p2.c * p2.c * p2.c * p2.c * p2.c, "p3")
=end


=begin
$BJ#AG?t$N$+$1;;(B(3)

* $BJ#AG?tF1;N$N$+$1;;!a3HBg!\2sE>(B
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
=end


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
