require 'rails_helper'

RSpec.describe NotificationController, type: :controller do
  describe 'POST #create' do
    let(:valid_attributes) do
      {
        "callId": 'asd3ad3w90d',
        "timestamp": '2020-08-23T15:10:47.750079',
        "duration": {
          "value": '5',
          "unit": 'MINUTES'
        },
        "waitingTime": {
          "value": '1450',
          "unit": 'MILLISECONDS'
        },
        "agentData": {
          "agentId": '49nvfos95a',
          "agentName": 'Jane',
          "agentEmail": 'jane@johndoecc.com'
        },
        "callData": {
          "callerNumber": '+10010020003',
          "ccNumber": '+19876543210',
          "direction": 'INBOUND'
        },
        "customerStatus": 'VIP'
      }
    end

    it 'returns a success response' do
      post :create, params: valid_attributes
      expect(response.status).to eq 200
    end

    it 'adds a new call log entry' do
      expect do
        post :create, params: valid_attributes
      end.to change(CallLog, :count).by(1)
    end

    it 'sets all expected attributes' do
      post :create, params: valid_attributes
      cl = CallLog.last
      expect(cl.call_id).to eq(valid_attributes[:callId])
      expect(cl.timestamp).not_to be_nil
      expect(cl.agent_name).to eq(valid_attributes[:agentData][:agentName])
      expect(cl.caller_number).to eq(valid_attributes[:callData][:callerNumber])
    end
  end
end
