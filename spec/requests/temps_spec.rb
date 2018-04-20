require 'rails_helper'

RSpec.describe 'Temps API', type: :request do
  let(:user) { create(:user) }
  let!(:project) { create(:project, user_id: user.id) }
  let!(:temps) { create_list(:temp, 10, project_id: project.id) }
  let(:project_id) { project.id }
  let(:id) { temps.first.id }
  let(:headers) { valid_headers }

  describe 'GET projects/:project_id/temps' do
    before { get "/projects/#{project_id}/temps", params: {}, headers: headers }

    context 'when project exists' do
      context 'when project belongs to user' do
        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end

        it 'returns all temps' do
          expect(json.size).to eq (10)
        end
      end

      context 'when project belongs to other user' do
        include_examples "other user's project"
      end
    end

    context 'when project does not exist' do
      let(:project_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Project/)
      end
    end
  end

  describe 'GET /projects/:project_id/temps/:id'  do
    before { get "/projects/#{project_id}/temps/#{id}", params: {}, headers: headers }

    context 'when project belongs to other user' do
      include_examples "other user's project"
    end

    context 'when temp exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the temp' do
        expect(json['id'])
      end
    end

    context 'when temp does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Temp/)
      end
    end
  end

  describe 'POST /projects/:project_id/temps' do
    let(:valid_attributes) { { value: 32.02 }.to_json }

    before { post "/projects/#{project_id}/temps", params: valid_attributes, headers: headers }

    context 'when project belongs to other user' do
      include_examples "other user's project"
    end

    context 'when attributes are valid' do
      it 'returns a 201 status code' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      let(:valid_attributes) { {} }

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Value can't be blank/)
      end
    end
  end

  describe 'PUT /projects/:project_id/temps/:id' do
    let(:valid_attributes) { { value: temp_value }.to_json }
    let(:temp_value) { 32 }

    before { put "/projects/#{project_id}/temps/#{id}", params: valid_attributes, headers: headers }

    context 'when project belongs to other user' do
      include_examples "other user's project"
    end

    context 'when temp exists' do
      it 'returs status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the temp' do
        updated_temp = Temp.find(id)
        expect(updated_temp.value).to eq(temp_value)
      end
    end

    context 'when the temp does not exist' do
      let(:id) { 0 }

      it 'returns a status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Temp/)
      end
    end
  end

  describe 'DELETE /projects/:id' do
    before { delete "/projects/#{project_id}/temps/#{id}", params: {}, headers: headers }

    context 'when project belongs to other user' do
      include_examples "other user's project"
    end

    context 'when the temp exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end

    context 'when the temp does not exist' do
      let(:id) { 0 }

      it 'returns a status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Temp/)
      end
    end
  end
end
