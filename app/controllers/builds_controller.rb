class BuildsController < ApplicationController
    get '/builds' do
        if logged_in?
            @builds = Build.all
            erb :'builds/index'
        else
            erb:'users/login', locals: {message: "Log In First"}
        end
    end
end