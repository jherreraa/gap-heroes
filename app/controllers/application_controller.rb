class ApplicationController < ActionController::Base
	protect_from_forgery with: :null_session
	http_basic_authenticate_with name: "my_user", password: "my_password"	
end
