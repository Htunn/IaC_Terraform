class WebServer < WEBrick::HTTPServlet::AbstractServlet
    def do_GET(request, response)
        case request.path
        when "/"
            response.status = 200
            response['Content-type'] = 'text/plain'
            response.body = 'Hello, World'
        when "/api"
            response.status = 201
            response['Content-type'] = 'application/json'
            response.body = '{"foo": "bar"}'
        else
            response.status = 404
            response['Content-Type'] ='text/plain'
            response.body = 'Not Found'
        end
    end
end

# This will only run if this script was callled directly from the CLI, but
# not if it was required from another file
if __FILE__ == $0
    # Run the server on localhost at port 8000
    server = WEBrick::HTTPServlet.new :Port => 8000
    server.mount '/', WebServer

    # shutdown the server on CTRL+C
    trap 'INT' do server.shutdown end
    
    # start the server
    server.start
end