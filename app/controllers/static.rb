enable :sessions

get '/' do
  @questions = Question.all
  erb :index
end

get '/signup' do
  session[:user_id] ||= nil
  if session[:user_id]
    redirect '/logout' #logout form
  end

  erb :signup
end

#signup action
post '/signup' do
  if params[:password] != params[:confirm_password]
    redirect "/signup"
  end

  user = User.new(email: params[:email], first_name: params[:first_name], last_name: params[:last_name])
  user.encrypt_password(params[:password])
  if user.save!
    session[:user_id] = user.id
    redirect "/users/:user_id" #user dashboard page
  else
    redirect "/signup"
    #error message?
  end
end

#login form
get '/login' do
  if session[:user_id]
    redirect '/logout'
  end

  erb :login
end

#login action
post '/login' do
  if session[:user_id]
    redirect "/users/:user_id"
  end

  user = User.authenticate(params[:email], params[:password])
  if user
    session[:user_id] = user.id
    redirect '/users/:user_id'
  else
    redirect "/login"
  end
end

#logout form
get '/logout' do
  unless session[:user_id]
    redirect '/login'
  end

  erb :logout
end

#logout action
delete '/session' do
  session[:user_id] = nil
  redirect '/'
end

# check whethere bug is or not
get '/users/:user_id' do
  @user = User.find(session[:user_id])
  if @user
    erb :profile
  else
    redirect '/login'
  end
end

#Question create page
get '/users/:user_id/questions/new' do
  @user = User.find(session[:user_id])
  if @user
    erb :create_question
  else
    redirect '/login'
  end
end

#Question post form
post '/users/:user_id/questions/new' do
  @question = Question.new(question_title: params[:question_title], question_content: params[:question_content])
  if @question.save
    redirect '/'
  else
    redirect '/users/:user_id/questions/new'
    # error message?
  end
end

