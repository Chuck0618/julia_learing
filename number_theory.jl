using Plots


mutable struct Arrow
    origin_x::Float64
    origin_y::Float64 
    vector_x::Float64
    vector_y::Float64
end
const deg=pi/180;
function left_rotation(theta::Float64,ar::Arrow)
    M=Float16[cos(theta*deg) sin(theta*deg); sin(theta*deg) cos(theta*deg)];
    return [ar.origin_x,ar.origin_y]+M*[ar.vector_x,ar.vector_y];
end

function left_rotation!(theta::Float64,ar::Arrow)
    M=Float16[cos(theta*deg) -sin(theta*deg); sin(theta*deg) cos(theta*deg)];
    ux,uy=M*[ar.vector_x,ar.vector_y];
    ar.origin_x+=ux;
    ar.origin_y+=uy;
    ar.vector_x=ux;
    ar.vector_y=uy;
    nothing
end

ar=Arrow(0,0,1,0);
tx,ty= left_rotation(120.0, ar);


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

A,B,data_x,data_y=get_seq(111,1000);

plot(data_x,data_y,aspect_ratio=1,legend=:none);

A,B,data_x,data_y=get_seq(321,1000);

plot(data_x,data_y,aspect_ratio=1,legend=:none)

A,B,data_x,data_y=get_seq(2471,1000);
plot(data_x,data_y,aspect_ratio=1,legend=:none)

function data_plot(N::Int)
    A,B,data_x,data_y=get_seq(N,1000);
    plot(data_x,data_y,aspect_ratio=1,legend=:none)
end
data_plot(24724)
