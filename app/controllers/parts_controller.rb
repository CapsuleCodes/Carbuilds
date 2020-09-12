class PartsController < ApplicationController
    get 'builds/:id/parts/new' do
        if logged_in?
            @build = Build.find(params[:id])
        else
            erb :'user/login', locals: {message: "Login to continue"}
        end
    end

    post '/builds/:id' do
        if params.value.any? {|value| value == ""}
           @build = Build.find(params[:id])
           erb :'parts/new', locals: {message: "Incomplete"}
        else
           @build = Build.find(params[:id])
           @part = Part.new(name: params[:id])
           @part.save
           @build.parts << @part
           redirect to "/builds/#{@build.id}"
        end
    end

    delete '/builds/:id/parts/:part_id/delete' do
        @build = Build.find(param[:id])
        @part = Part.find(params[:part_id])
        if logged_in?
            @build = Build.find(params[:id])
            if @build.user_id == session[:user_id]
                @part = Part.find(params[:part_id])
                @part.delete
                redirect to "/builds/#{@build.id}"
            end
        else
            erb :'users/login', locals: {message: "Please Login!"}
        end
    end
end 

