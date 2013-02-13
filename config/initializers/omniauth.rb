OmniAuth.config.logger = Rails.logger

#OmniAuth.config.full_host = "http://localhost:3000"

#Rails.application.config.middleware.use OmniAuth::Builder do
  # If you don't need a refresh token -- if you're only using Google for account
  # creation/auth and don't need google services -- set the access_type to 'online'.
  # Also, set the approval prompt to an empty string, since otherwise it will be set
  # to 'force', which makes users manually approve to the Oauth every time they 
  # log in.
  # See http://googleappsdeveloper.blogspot.com/2011/10/upcoming-changes-to-oauth-20-endpoint.html
#  provider :google_oauth2, '939318209513.apps.googleusercontent.com', 'GRZJM66tGXRIAKJq87ZdHIP9', {access_type: "offline", approval_prompt: ""}#, :provider_ignores_state => true
#end


Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, '7a65508273ec80a93531', 'ea029fc08d9c60d9bb89650a2080e03f4a34241c'
  provider :google_oauth2, '939318209513.apps.googleusercontent.com',     'GRZJM66tGXRIAKJq87ZdHIP9', {:access_type => 'online', :approval_prompt => ''} 
end
