class SessionsController < ApplicationController
    def index
        session[:page_views]||= 0
        render json: { session: session, cookies: cookies.to_hash }
    end
end
