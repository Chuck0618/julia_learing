
using FileIO,Plots,Luxor
data = float.(Gray.(load("heben.png")));
data = data.^2.5;
m,n = size(data)

cx,cy=240,340
cr=130;


# function test_circle_mask(img)
#     m,n= size(img)
#     mask = [(i-cx)^2+(j-cy)^2<cr^2 for i in 1:m, j in 1:n]
#    return mask.*img;
#    # also can return img[mask];
# end
# plot(test_circle_mask(Gray.(data)))

function distance_pix0(a,b)
    if (a>b)
        return 2*(1-b/a)^2;
    elseif a<b-0.1
        return (b-a-0.1)*0.2;
    else
        return 0
    end
end
function distance_pix(a,b)
    if (a>b)
        return (a-b)/(b+0.1);
    elseif a<b-0.1
        return (b-a-0.1)^2*3.0;
    else
        return 0
    end
end

function distance(A,B)
    return sum(map(distance_pix,A,B));
end

mask_pic = [(i-cx)^2+(j-cy)^2<cr^2 for i in 1:m, j in 1:n];
data_mask = data[mask_pic];

const N = 200;
const Pin_list=[
Point(cos(s/N*2*pi)*cr+cx, sin(s/N*2*pi)*cr+cy) for  s in 1:N];

p2=plot(Gray.(data))


function drawline_on_matrix(img::Matrix{RGB24}, P1::Point,P2::Point)
    new_img= copy(img);
    Drawing(new_img)
    setline(1) # line_width= 1
    setcolor(0.2,0.2,0.2,0.55);
    line(P1,P2,action= :fillstroke);
    finish()
    return new_img;
end

pointer =1;
img = RGB24.(ones(m,n));
dist_list= zeros(N);
it_max= 1000
pointer_record=[pointer]
num_record=zeros(Int,N);
num_record[pointer]=1;
weight=num_record*0.0 .+1.0;

for it in 2:it_max
    for i in eachindex(Pin_list) 
        if i == pointer
        dist_list[i]=Inf
        else
            img1=drawline_on_matrix(img,Pin_list[pointer],Pin_list[i]);
            floag_img1=float.(Gray.(img1[mask_pic]));
            dist_list[i]=distance(floag_img1, data_mask);
        end
    end
    #weight=num_record*0.03.+1.0;
    new_pointer= argmin(dist_list.*weight)
    img=drawline_on_matrix(img,Pin_list[pointer],Pin_list[new_pointer]);
    pointer=new_pointer 
    num_record[pointer]+=1;
    append!(pointer_record,pointer);
    if it % 30 == 0
        per= it/it_max*100;
        println("$per %");
        p1=plot(Gray.(img))
        #plot(p1,p2)
        println("----------");
    end
end


p1=plot(Gray.(img),size=(800,600));
p2=plot(Gray.(data),size=(800,600))
p3=plot(1:it_max,pointer_record);
plot(p1,p2)


