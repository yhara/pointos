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
Circle.new!(O, p1.c.magnitude)

p2 = Point.new!(Complex.polar(1, PI/6), "p2")
Line.new!(O, p2)

p3 = Point.new!(p1.c * p2.c * p2.c * p2.c * p2.c * p2.c, "p3")
=end


=begin
複素数のかけ算(3)

* 複素数同士のかけ算＝拡大＋回転
=end

=begin
点と直線の距離

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
