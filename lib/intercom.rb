require "erb"

class Intercom

  def self.call(env)
    new(env).response.finish
  end
  
  def initialize(env)
    @request = Rack::Request.new(env)
  end

  def response

    case @request.path
    when "/" then Rack::Response.new(render("index.html.erb"))
    when "/with_turbolinks" then Rack::Response.new(render("with_turbolinks.html.erb"))
    when "/without_turbolinks" then Rack::Response.new(render("without_turbolinks.html.erb"))
    when "/2" then Rack::Response.new(render("page2.html.erb"))
    else Rack::Response.new("Not Found", 404)
    end

  end

  def render(template)
    path = File.expand_path("../views/#{template}", __FILE__)
    ERB.new(File.read(path)).result(binding)
  end
end