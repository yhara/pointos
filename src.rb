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
Circle.new!(O, p1.c.magnitude)

p2 = Point.new!(Complex.polar(1, PI/6), "p2")
Line.new!(O, p2)

p3 = Point.new!(p1.c * p2.c * p2.c * p2.c * p2.c * p2.c, "p3")
=end


=begin
$BJ#AG?t$N$+$1;;(B(3)

* $BJ#AG?tF1;N$N$+$1;;!a3HBg!\2sE>(B
=end

=begin
$BE@$HD>@~$N5wN%(B

=end

A = Point(1.2+2.4.i)
B = Point(-1.5+2.5.i)
C = Point(1.8+3.7.i)
Line.new!(B, C)

#tmp = ((p3.c - p2.c)/(p3.c - p2.c).abs).conj
#p4 = Point.new!(tmp , "p3")
#Line.new!(O, p4)
#
#c = p1.c
#[p1, p2, p3].each do |pk|
#  pk.c -= c
#  pk.c *= tmp
#end
