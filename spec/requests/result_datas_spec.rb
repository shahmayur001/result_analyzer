# spec/requests/users_spec.rb
require 'rails_helper'

RSpec.describe 'Result Data API', type: :request do
  describe 'POST /results_data' do
    
    context 'with invalid parameters' do
      let(:valid_params) do
        {
          "result_data": {
            "subject": "Science",
            "timestamp": "2022-04-18 12:01:34.678",
            "marks": 85.25
          }
        }
      end

      it 'creates a user' do
        post '/results_data', params: valid_params, as: :json
        expect(response).to have_http_status(200)
        expect(ResultsData.count).to eq(1)
        expect(response.body).to eq('Result data is successfully stored')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        {
          wrong_key: { }
        }
      end

      it 'does not create a new result data record' do
        expect {
          post "/results_data", params: invalid_params
        }.to raise_error(ActionController::ParameterMissing)
      end
    end

  end
end
