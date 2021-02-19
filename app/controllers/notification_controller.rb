class NotificationController < ApplicationController
  protect_from_forgery except: :create
  before_action :set_call_log, only: [:create]

  def index
    @calls = CallLog.all.order(created_at: :desc)
  end

  def create
    UserMailer.with(call_log: @cl).notification_email.deliver_later if @cl.customer_status == 'VIP'
    render json: @cl.to_json
  end

  private

  # if any of the below referenced attributes will be required then throw
  # an exception if not present
  def set_call_log
    @cl = CallLog.new
    @cl.call_id = params['callId'] if params['timestamp'].present?
    # DateTime.strptime("2020-08-23T10:35:77","%Y-%m-%dT%H%M%N")
    @cl.timestamp = DateTime.strptime(params['timestamp'], '%Y-%m-%dT%H:%M:%N') if params['timestamp'].present?
    @cl.customer_status = params['customerStatus'] if params['customerStatus'].present?
    if params['duration'].present?
      @cl.duration = convert_to_milliseconds(params['duration']['value'].to_i, params['duration']['unit'])
    end
    if params['waitingTime'].present?
      @cl.waiting_time = convert_to_milliseconds(params['waitingTime']['value'].to_i, params['waitingTime']['unit'])
    end
    if params['agentData'].present?
      @cl.agent_id = params['agentData']['agentId']
      @cl.agent_name = params['agentData']['agentName']
      @cl.agent_email = params['agentData']['agentEmail']
    end
    if params['callData'].present?
      @cl.caller_number = params['callData']['callerNumber']
      @cl.cc_number = params['callData']['ccNumber']
      @cl.direction = params['callData']['direction']
    end
    @cl.save!
  end

  def convert_to_milliseconds(value, unit)
    return value * 3600 if unit == 'MINUTES'
    return value * 60 if unit == 'SECONDS'

    value
  end
end
