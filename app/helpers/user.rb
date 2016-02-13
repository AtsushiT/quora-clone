helpers do

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by_id(session[:user_id])
    end
  end

  def logged_in?
    !current_user.nil?
  end
end

def truncate_words(text, length, end_string = ' ...')
  words = text.split(" ")
  words = words[0..(length-1)].join(' ') + (words.length > length ? end_string : '')
end
