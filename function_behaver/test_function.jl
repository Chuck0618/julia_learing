
A=100
mutable struct Mytype
    my1::Int
    my2::Int
end

B=[1,2,4,6]
function fun(fun_A::Int, fun_B)
    global A
    println(fun_A == A)
    println(fun_A === A)
    fun_A =2
    fun_B[2]=1000
    println(fun_A == A)
    println(fun_A === A)
    nothing
end

fun(A,B)
println(B)

me = Mytype(111,222)


function fun(fun_C::Mytype)
    fun_C.my1=23423432423
    nothing
end

fun(me)
println(me)

function fib(n::Integer)
    return n+1
end

fib(23)

function fib(n::Int)
    return n-1
end

fib(23)