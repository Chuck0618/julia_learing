# depend on modules FileIO.jl, ImageIO.jl

using FileIO,Images,Plots
img=load("/home/huchq/tmp/testimg.bmp");
img=Gray.(img); # tranverse to Gray image
plot(img)

const pic_m,pic_n=10,10;
pic_data =Gray.(1.0*ones(pic_m,pic_n));# pic_data 的位标， (x1,y1) 到 （x_2, y_2）的矩形区域。
List_Global=[];# 每个相素的坐标。


mutable struct Point
    Px::Float16
    Py::Float16
end



struct Canvas
    LU::Point 
    RD::Point
    pic_data::Matrix{Any}
    pic_m::Int
    pic_n::Int
    List::Vector{Point}
    function Canvas()
        LU=Point(-1,1);
        RD=Point(1,-1);
        pic_m=10;
        pic_n=10;
        delta_x=(RD.Px-LU.Px)/pic_m;
        delta_y=(LU.Py-RD.Py)/pic_n;
        # for i in [1:pic_m]
        #     for j in [1:pic_n]
        #         List[i,j]=LU+Point((i-0.5)*delta_x,(j-0.5)*delta_y);
        #     end
        # end
        return new(LU,RD,Float16.(pic_data),pic_m,pic_n,List_Global)
    end
end


can = Canvas();

function show(can::Canvas)
    return plot(Gray.(can.pic_data));
end



struct Canvas_with_coor<:Canvas

end
function draw(can::Canvas)
    pic=can.pic_data;
    pic[1,1]=0;
    pic[2,2]=0;
end