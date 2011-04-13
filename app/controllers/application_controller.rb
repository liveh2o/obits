class ApplicationController < ActionController::Base
  protect_from_forgery
  
  protected
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
