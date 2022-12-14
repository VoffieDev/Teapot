require_relative 'main'

server = Teapot.new(4567)

begin
  server.get('/') do |response|
    response.create_cookie('example', 'cookie')
    response.body = File.read('views/index.html')
  end

  server.get('/redirect') do |response|
    response.redirect('/')
  end

  server.get('/slim') do |response|
    response.body = server.slim(:index)
  end
  server.launch
rescue Interrupt
  print 'The heat of the Teapot has worn off'.yellow
end
