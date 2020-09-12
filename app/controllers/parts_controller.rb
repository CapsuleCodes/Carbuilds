class PartsController < ApplicationController
    get 'projects/:id/parts/new' do
        if logged_in?
            @build = Build.find(params[:id])
        else
            erb :'user/login', locals: {message: "Login to continue"}
        end
    end

    post '/projects/:id' do
        if params.value.any? {|value| value == ""}
           @build = Build.find(params[:id])
           erb :'parts/new', locals: {message: "Incomplete"}
        else
           @build = Build.find(params[:id])
           @part = Part.new(name: params[:id])
           @part.save
           @project.parts << @part
           redirect to "/projects/#{@project.id}"
        end
    end

    delete '/projects/:id/parts/:part_id/delete' do
        @build = Build.find(param[:id])
        @part = Part.find(params[:part_id])
        if logged_in?
            @build = Build.find(params[:id])
            if @build.user_id == session[:user_id]
                @part = Part.find(params[:part_id])
                @part.delete
                redirect to "/projects/#{@project.id}"
            end
        else
            erb :'users/login', locals: {message: "Please Login!"}
        end
    end
end