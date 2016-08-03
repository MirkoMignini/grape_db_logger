require 'spec_helper'
require 'grape'
require 'rack/test'

describe 'API' do
  include Rack::Test::Methods

  class API < Grape::API
    use GrapeDbLogger::Logger

    get '/' do
    end

    post '/' do
    end
  end

  def app
    API
  end

  it 'creates a log entry' do
    get '/'
    expect(GrapeDbLogger::GrapeLog.count).not_to eq(0)
  end

  it 'logs created_at' do
    post '/'
    log = GrapeDbLogger::GrapeLog.last
    expect(log.created_at).not_to eq(nil)
  end

  it 'logs request_method' do
    post '/'
    log = GrapeDbLogger::GrapeLog.last
    expect(log.request_method).to eq('POST')
  end

  it 'logs path' do
    post '/'
    log = GrapeDbLogger::GrapeLog.last
    expect(log.path).to eq('/')
  end

  it 'logs params' do
    params = { param1: '1', param2: 'hello', password: 'hide_me' }
    post '/', params
    log = GrapeDbLogger::GrapeLog.last
    params_filterd = params.clone
    params_filterd['password'] = 'FILTERED'
    expect(log.params).to eq(params_filterd.to_json)
  end
end
