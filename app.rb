require 'sinatra'

get '/' do
    "Hello, world"
end

set :public_folder, 'public'
