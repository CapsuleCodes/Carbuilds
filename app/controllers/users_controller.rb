class UsersController < ApplicationController
    get "/signup" do
        if !logged_in?
            erb :"/users/signup"
        else    
            redirect to '/builds'
        end
    end

    post '/signup' do
        if params

end