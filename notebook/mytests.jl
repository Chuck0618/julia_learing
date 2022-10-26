module mytests
export mytest, va

va::String="undefined"
struct mytest
    a::Int
    b::String
end

function __init__()
    println("hello, mytests module")
    global va="hello"
end

end