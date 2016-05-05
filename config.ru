require File.expand_path('../config/environment', __FILE__)
require 'rack/cors'

use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: :any
  end
end

run Rack::URLMap.new({
  "/api" => API,
  "/" => Rack::Directory.new("public")
})

use Rack::Static, urls: ['/css', '/js'], root: 'public', index: 'index.html'
