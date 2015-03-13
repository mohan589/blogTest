class LinkedinShareController < ApplicationController
 
  def init_client
     
    key = "78349yyp7ihbem"
    secret = "2E0s6mBxXzHO2mdX"
 
    linkedin_configuration = { :site => 'https://api.linkedin.com',
        :authorize_path => '/uas/oauth/authenticate',
        :request_token_path =>'/uas/oauth/requestToken?scope=rw_nus',
        :access_token_path => '/uas/oauth/accessToken' }
 
    @linkedin_client = LinkedIn::Client.new(key, secret,linkedin_configuration )
  end
 
  def auth
    init_client
   
    cookies["title"] = { :value => "#{params[:title]}", :expires => 1.minute.from_now }
    cookies["url"] = { :value => "#{params[:url]}", :expires => 1.minute.from_now }
   
    request_token = @linkedin_client.request_token(:oauth_callback => "http://#  {request.host_with_port}/linkedin_share/callback")
    session[:rtoken] = request_token.token
    session[:rsecret] = request_token.secret
   
    redirect_to @linkedin_client.request_token.authorize_url
  end
 
  def callback
    init_client
   
    if session[:atoken].nil?
      pin = params[:oauth_verifier]
      atoken, asecret =  @linkedin_client.authorize_from_request(session[:rtoken], session[:rsecret], pin)
      session[:atoken] = atoken
      session[:asecret] = asecret
    else
      @linkedin_client.authorize_from_access(session[:atoken], session[:asecret])
    end
 
    c = @linkedin_client
     
    title = "#{cookies["title"]}"
    url = "#{cookies["url"]}"
 
    c.add_share({
        :comment => title,
        :content => {
          :title => title,
          :submitted_url => url,
          :submitted_image_url => "IMAGE PATH",
          :description => 'YOUR DESCRIPTION'
        }
      })
 
    redirect_to root_path
  end
end