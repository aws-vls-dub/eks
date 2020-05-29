require 'sinatra'
require 'mongo'
require 'logger'
require 'net/http'
require 'json'
require 'uri'

configure do
  set :bind, '0.0.0.0'
  set :server, :puma
  set :logger, $logger
  $logger = Logger.new(STDOUT)
  $logger.level = Logger::DEBUG
end


ALL_NET_HTTP_ERRORS = [
  Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError,
  Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError
]

get "/" do
  otherMes = "The frontend page is working"
	erb :show, :locals => {otherMessage: otherMes}
end

get "/backend" do
	theMes = "backend page"
	otherMes = {}
  backendHost = ENV["backend_service_host"] || "backend_service_host"
  backendPort = ENV["backend_service_port"] || "backend_service_port"
  begin
    http = Net::HTTP.new(backendHost, backendPort)
    request = Net::HTTP::Get.new('/greet')
    response = http.request(request)
    if response.code == "200"
      result = JSON.parse(response.body)
      erb :backEnd, :locals => {:quote => result["quote"], :author => result["author"]}
    end
  rescue SocketError => er
    $logger.error "Unable to fetch environment variables backend_service_host and backend_service_port"
    otherMes = "Backend unavailable...<br />" + er.message
    erb :error, :locals => {otherMessage: otherMes}
  rescue *ALL_NET_HTTP_ERRORS => err
    otherMes = "Cannot load the backend..socket error....<br />" + err.message
    erb :error, :locals => {otherMessage: otherMes}
  end

end
