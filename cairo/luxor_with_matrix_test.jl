using Luxor, Images
Drawing(500, 500, "my-drawing4.svg")
background("white")
origin()
setcolor(0.75,0.75,0.75)
# setcolor("gray")
arrow(Point(-22, -2),Point(222,222))
# setcolor("red")
line(Point(-200, -200),Point(20,0), action=:fillstroke)
# arrow(Point(100, 0),Point(200,0))
finish()

