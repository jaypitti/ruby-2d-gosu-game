require 'celluloid/current'
require 'celluloid/io'

class Server
  include Celluloid::IO
  finalizer :shutdown

  def initialize(host, port)
    puts "Starting Server on #{host}:#{port}."
    @server = TCPServer.new(host, port)
    @objects = Hash.new # all the objects including tanks and bullets, key is sprite uuid
    @players = Hash.new # the players in the game (ie the tanks), key is server:port
    async.run
  end

  def shutdown
    @server.close if @server
  end

  def run
    loop { async.handle_connection @server.accept }
  end

  def handle_connection(socket)
    _, port, host = socket.peeraddr
    user = "#{host}:#{port}"
    puts "#{user} has joined the arena."

    loop do
          data = socket.readpartial(4096)
          data_array = data.split("\n")
          if data_array and !data_array.empty?
            begin
              data_array.each do |row|
                message = row.split("|")
                if message.size == 11
                  case message[0] # first item in message tells us what to do, the rest is the sprite
                  when 'obj'
                    @players[user] = message[1..10] unless @players[user]
                    @objects[message[1]] = message[1..10]
                  when 'del'
                    @objects.delete message[1]
                  end
                end
                response = String.new
                @objects.each_value do |obj|
                  (response << obj.join("|") << "\n") if obj
                end
                socket.write response
              end
            rescue Exception => exception
          puts exception.backtrace
        end
      end # end data
    end # end loop
  rescue EOFError => err
    player = @players[user]
    puts "#{player[3]} has left arena."
    @objects.delete player[0]
    @players.delete user
    socket.close
  end
end

server, port = ARGV[0] || "192.168.1.44", ARGV[1] || 1234
Server.supervise as: :supervisor, args: [server, port.to_i]
trap("INT") do
  supervisor.terminate
  exit
end

sleep
