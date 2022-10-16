using Luxor, Images
Drawing(500, 500, "my-drawing4.png")
background("white")
origin()
const origin_color=(0.75,0.75,0.75,0.5);
const origin_line_width = 8;
setcolor(origin_color);
# setcolor("gray")
arrow(Point(-22, -2),Point(222,222))
# setcolor("red")
setline(origin_line_width)
setlinecap(:round);
line(Point(-200, -200),Point(200,200), action=:fillstroke)
line(Point(-200, 0),Point(-200,200), action=:fillstroke)
line(Point(-200, 200),Point(200,200), action=:fillstroke)
line(Point(-20, -200),Point(-20,200), action=:fillstroke)
line(Point(-0, -200),Point(0,200), action=:fillstroke)
line(Point(-100, 150),Point(100,-150),action=:fillstroke)
# arrow(Point(100, 0),Point(200,0))
finish()


using FileIO
data = Float16.(Gray.(load("my-drawing4.png")));

function test_circle_mask(img::Matrix{Gray{N0f8}})
cx,cy=200,200
cr=100;
    m,n= size(img)
    mask = [(i-cx)^2+(j-cy)^2<cr^2 for i in 1:m, j in 1:n]
   return mask.*img;
   # also can return img[mask];
end


