class UsersController < ApplicationController
    get "/signup" do
        if !logged_in?
            erb :"/users/signup"
        else    
            redirect to '/builds'
        end
    end

  post '/signup' do
     if params.value.any? {|value| value == ""}
         erb :'users/signup', locals: {message: "Unable to Proceed"}
     else
         @user = User.new(username: params[username], email: params[:email], password: params[:password])
         @user.save
         session[:user_id] = @user.user_id
         redirect to '/builds'
     end
  end

  get '/login' do 
      if !logged_in?
         erb: '/users/login'
      else    
         redirect to '/builds'
      end
  end 

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
        session[:user_id] = user.id 
        redirect to '/builds'
    else
        erb :'users/login', locals: {message: "Username or password incorrect!"}
    end
  end


    get '/logout' do
        if session[:user.id] != nil
            session.destroy
            redirect to '/'
        else
            redirect to '/projects'
        end
    end
end