#=
谷角猜想的可视化做图 
给定 N 生成 序列
$$ A = N_0, N_1, N_2, ... $$
其中 $N_0= N$, 迭代
Case_1: N_{i+1} = N_i /2 when N_i is even;
Case_2: N_{i+1} = (3*N_i+1) when N_i is odd;

从原点(origin_x,origin_y)出发，指定箭头`ar`尖点向量 (vector_x, vector_y)
如果是Case_1, 箭头做 \alpha 变化，如果是 Case_2, 箭头做 \beta变化。
用 (data_x, data_y) 标记 `ar`的箭柄位置，生成图像。
=#
using Plots


mutable struct Arrow
    origin_x::Float64
    origin_y::Float64 
    vector_x::Float64
    vector_y::Float64
end
const deg=pi/180;
# function left_rotation(theta::Float64,ar::Arrow)
#     M=Float16[cos(theta*deg) sin(theta*deg); sin(theta*deg) cos(theta*deg)];
#     return [ar.origin_x,ar.origin_y]+M*[ar.vector_x,ar.vector_y];
# end

# 这里用于箭头的变换。
function left_rotation!(theta::Float64,ar::Arrow)
    M=Float16[cos(theta*deg) -sin(theta*deg); sin(theta*deg) cos(theta*deg)];
    ux,uy=M*[ar.vector_x,ar.vector_y];
    ar.origin_x+=ux;
    ar.origin_y+=uy;
    ar.vector_x=ux;
    ar.vector_y=uy;
    nothing
end

# ar=Arrow(0,0,1,0);
# tx,ty= left_rotation(120.0, ar);

function get_seq(N::Int, L::Int=10)
    A=Int[N];
    B=Int[];
 
    ar=Arrow(0,0,1,0);
    data_x=Float64[ar.origin_x];
    data_y=Float64[ar.origin_y];
    for k in 1:L
        Ae=A[end];
        if Ae%2==0
            push!(A,Int(Ae//2));
            push!(B,0);
            left_rotation!(145.0,ar);
        else
            push!(A,Ae*3+1);
            push!(B,1);
            left_rotation!(-150.0,ar);
        end 
        push!(data_x,ar.origin_x);
        push!(data_y,ar.origin_y);
    end
    return A,B,data_x,data_y;
end

# A,B,data_x,data_y=get_seq(111,1000);

# plot(data_x,data_y,aspect_ratio=1,legend=:none);

# A,B,data_x,data_y=get_seq(321,1000);

# plot(data_x,data_y,aspect_ratio=1,legend=:none)

# A,B,data_x,data_y=get_seq(2471,1000);
# plot(data_x,data_y,aspect_ratio=1,legend=:none)

function data_plot(N::Int)
    A,B,data_x,data_y=get_seq(N,1000);
    plot(data_x,data_y,aspect_ratio=1,legend=:none)
end

data_plot(24724)
