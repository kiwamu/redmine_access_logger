require 'application_controller'
require 'json'

module AccessLoggerPlugin
  module ApplicationControllerPatch
    def self.included(base) # :nodoc:    
      base.send(:include, InstanceMethods)     
      base.class_eval do      
        unloadable
        before_filter :access_logging
      end
    end
    
    module InstanceMethods    
      def access_logging 
        req_param = params.reject{|k,v| k == "password"}.update({"user" => User.current.login}).to_json
        user = User.current.login.blank? ? "-" : User.current.login
        message = "#{user} #{req_param}" 
        log = Logger.new(File.join(RAILS_ROOT, "/log/access.log"), "daily") 
        log.formatter = Logger::Formatter.new 
        log.info(message) 
        log.close
      end 
    end
  end
end

::ApplicationController.send(:include, AccessLoggerPlugin::ApplicationControllerPatch)
