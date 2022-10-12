using Luxor, Images
Drawing(25, 25, "my-drawing.png")
origin()
background(randomhue()...)
sethue("red")
fontsize(20)
fontface("Georgia")
text("42", halign=:center, valign=:middle)
mat = image_as_matrix()
finish()


Fmat=Float16.(Gray.(mat));