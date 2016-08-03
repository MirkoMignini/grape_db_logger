require 'grape'

module GrapeDbLogger
  class Logger < ::Grape::Middleware::Base
    def after
      @request = ::Rack::Request.new(@env)
      options = {
        request_method: @request.request_method,
        path: @request.path,
        params: params,
        referer: @request.referer,
        user_agent: @request.user_agent,
        ip: @request.ip,
        created_at: DateTime.current,
      }
      log(options)
      super
    end

    def filter_params
      %w(password password_confirmation)
    end

    def params
      params = @request.params.clone
      filter_params.each do |key|
        params[key] = 'FILTERED' if params.key?(key)
      end
      params.to_json
    end

    def log(options)
      GrapeLog.create(options)
    end
  end
end
