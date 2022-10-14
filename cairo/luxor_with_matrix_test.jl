using Luxor, Images
Drawing(500, 500, "my-drawing4.svg")
background("white")
origin()
setcolor(0.75,0.75,0.75)
# setcolor("gray")
arrow(Point(0, 0),Point(250,250))
Luxor.line(Point(-200, -200),Point(20,0))
finish()

