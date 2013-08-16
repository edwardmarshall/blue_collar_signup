require 'sinatra'
require './mailer'

get '/' do
  redirect '/index.html'
end

post '/signup' do
  user_params = params.select {|k, _| ['email', 'name', 'telephone'].include?(k)}
  user = User.new(user_params)
  Mailer.send_signup(user)
  Mailer.send_notification(user)
  redirect '/index.html'
end

set :public_folder, 'public'

class User
  attr_accessor :email, :name, :telephone
  def initialize(params)
    self.email = params['email']
    self.name = params['name']
    self.telephone = params['telephone']
  end
end
