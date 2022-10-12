using WebSockets

serverWS = WebSockets.ServerWS((req) -> WebSockets.Response(200), 
(ws_server) -> (writeguarded(ws_server, "Hello, My Name is WebSockets.jl"); readguarded(ws_server)))


ta = @async WebSockets.with_logger(WebSocketLogger()) do
                WebSockets.serve(serverWS, port = 8000)
            end

WebSockets.HTTP.get("http://127.0.0.1:8000");


# HTTP.Messages.Response:
# """
# HTTP/1.1 200 OK
# Transfer-Encoding: chunked

# """

# julia> WebSockets.open("ws://127.0.0.1:8000") do ws_client
#                   data, success = readguarded(ws_client)
#                   if success
#                       println(stderr, ws_client, " received:", String(data))
#                   end
#               end;
# WebSocket(client, CONNECTED) received:Hello

# WARNING: Workqueue inconsistency detected: popfirst!(Workqueue).state != :queued

# julia> put!(serverWS.in, "close!")
# "close!"

# julia> ta
# Task (done) @0x000000000fc91cd0
