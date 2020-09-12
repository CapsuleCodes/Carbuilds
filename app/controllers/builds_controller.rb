
class buildsController < ApplicationController
      get '/builds' do
        if logged_in?
          @builds = build.all
          erb :'builds/index'
        else
          erb :'users/login', locals: {message: "You don't have access, please login"} 
        end
      end
    
      get '/builds/new' do
        if logged_in?
          erb :'builds/new'
        else
          erb :'users/login', locals: {message: "You don't have access, please login"}
        end
      end
    
      post '/builds' do
        if params.values.any? {|value| value == ""}
          erb :'builds/new', locals: {message: "Your missing information!"}
        else
          user = User.find(session[:user_id])
          @build = build.create(title: params[:title], budget: params[:budget], user_id: user.id)
          redirect to "/builds/#{@build.id}"
        end
      end
    
      get '/builds/:id' do 
        if logged_in?
          @build = build.find(params[:id])
          erb :'builds/show'
        else 
          erb :'users/login', locals: {message: "You don't have access, please login"}
        end
      end
    
      get '/builds/:id/edit' do
        if logged_in?
          @build = build.find(params[:id])
          if @build.user_id == session[:user_id]
           erb :'builds/edit'
          else
          erb :'builds', locals: {message: "You don't have access to edit this build"}
          end
        else
          erb :'users/login', locals: {message: "You don't have access, please login"}
        end
      end
    
      patch '/builds/:id' do 
        if params.values.any? {|value| value == ""}
          @build = build.find(params[:id])
          erb :'builds/edit', locals: {message: "You're missing information"}
          redirect to "/builds/#{params[:id]}/edit"
        else
          @build = build.find(params[:id])
          @build.title = params[:title]
          @build.budget = params[:budget]
          @build.save
          redirect to "/builds/#{@build.id}"
        end
      end
    
      delete '/builds/:id/delete' do 
        @build = build.find(params[:id])
        if session[:user_id]
          @build = build.find(params[:id])
          if @build.user_id == session[:user_id]
            @build.delete
            redirect to '/builds'
          else
            redirect to '/builds'
          end
        else
          redirect to '/login'
        end
      end
    
    end

    build