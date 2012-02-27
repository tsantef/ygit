class ApplicationController < ActionController::Base
  protect_from_forgery

  helper :Meta
  helper :Field

  protected

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == APP_CONFIG['basic_auth_user'] && password == APP_CONFIG['basic_auth_password']
    end
  end
   
  def add_breadcrumb name, url = ''
    @breadcrumbs ||= []
    url = eval(url) if url =~ /_path|_url|@/
    @breadcrumbs << {:name => name, :url => url}
  end
 
  def self.add_breadcrumb name, url, options = {}
    before_filter options do |controller|
      controller.send(:add_breadcrumb, name, url)
    end
  end
end
