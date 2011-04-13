class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :admin?
  
  protected
    def admin?
      controller_path =~ /admin/
    end

    def authorize
      if authenticate_with_http_basic do |username, password|
          username == 'admin' && password == 'deathandtaxes'
        end
      else
        request_http_basic_authentication
      end
    end

    def search_options(options={})
      options.merge({
        :star => true,
        :match_mode => :any,
        :field_weights => {
          :full_name  => 10,
          :name       => 8,
          :last_name  => 6,
          :first_name => 2
        }
      })
    end
end
