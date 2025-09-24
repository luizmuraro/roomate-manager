require 'rails_helper'

RSpec.describe 'Api::V1::Receipts', type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user, email: 'other@example.com', name: 'Other User') }
  let(:headers) { { 'Content-Type' => 'application/json' } }

  # Mock authentication for API testing
  before do
    allow_any_instance_of(Api::V1::ReceiptsController).to receive(:authenticate_user!).and_return(true)
    allow_any_instance_of(Api::V1::ReceiptsController).to receive(:current_user).and_return(user)
  end

  describe 'GET /api/v1/receipts' do
    let!(:receipt1) { create(:receipt, user: user, title: 'Grocery Receipt', amount: 50.00, category: :groceries) }
    let!(:receipt2) { create(:receipt, user: user, title: 'Gas Bill', amount: 80.00, category: :utilities) }
    let!(:other_receipt) { create(:receipt, user: other_user, title: 'Other Receipt', amount: 30.00) }

    it 'returns user receipts only' do
      get '/api/v1/receipts', headers: headers

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json.length).to eq(2)
      expect(json.map { |r| r['title'] }).to contain_exactly('Grocery Receipt', 'Gas Bill')
    end

    it 'filters by search term' do
      get '/api/v1/receipts?search=grocery', headers: headers

      json = JSON.parse(response.body)
      expect(json.length).to eq(1)
      expect(json[0]['title']).to eq('Grocery Receipt')
    end

    it 'filters by category' do
      get '/api/v1/receipts?category=utilities', headers: headers

      json = JSON.parse(response.body)
      expect(json.length).to eq(1)
      expect(json[0]['title']).to eq('Gas Bill')
    end

    it 'sorts by amount descending' do
      get '/api/v1/receipts?sort_by=amount_desc', headers: headers

      json = JSON.parse(response.body)
      expect(json[0]['title']).to eq('Gas Bill')  # 80.00
      expect(json[1]['title']).to eq('Grocery Receipt')  # 50.00
    end
  end

  describe 'GET /api/v1/receipts/:id' do
    let!(:receipt) { create(:receipt, user: user, title: 'Test Receipt', amount: 25.50) }

    it 'returns the receipt' do
      get "/api/v1/receipts/#{receipt.id}", headers: headers

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['title']).to eq('Test Receipt')
      expect(json['amount']['raw']).to eq(25.5)
      expect(json['amount']['formatted']).to eq('R$ 25,50')
    end

    it 'returns 404 for non-existent receipt' do
      get '/api/v1/receipts/99999', headers: headers

      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'POST /api/v1/receipts' do
    let(:valid_params) do
      {
        receipt: {
          title: 'New Receipt',
          amount: 35.00,
          category: 'groceries'
        }
      }
    end

    it 'creates a new receipt' do
      expect {
        post '/api/v1/receipts', params: valid_params.to_json, headers: headers
      }.to change(Receipt, :count).by(1)

      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body)
      expect(json['title']).to eq('New Receipt')
      expect(json['category']).to eq('groceries')
      expect(json['category_emoji']).to eq('🛒')
    end

    it 'returns errors for invalid data' do
      invalid_params = { receipt: { title: '', amount: -10 } }

      post '/api/v1/receipts', params: invalid_params.to_json, headers: headers

      expect(response).to have_http_status(:unprocessable_entity)
      json = JSON.parse(response.body)
      expect(json['errors']).to be_present
    end
  end

  describe 'PATCH /api/v1/receipts/:id' do
    let!(:receipt) { create(:receipt, user: user, title: 'Old Title') }

    it 'updates the receipt' do
      patch_params = { receipt: { title: 'Updated Title' } }

      patch "/api/v1/receipts/#{receipt.id}", params: patch_params.to_json, headers: headers

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['title']).to eq('Updated Title')
    end
  end

  describe 'DELETE /api/v1/receipts/:id' do
    let!(:receipt) { create(:receipt, user: user) }

    it 'deletes the receipt' do
      expect {
        delete "/api/v1/receipts/#{receipt.id}", headers: headers
      }.to change(Receipt, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end

  describe 'PATCH /api/v1/receipts/:id/link_to_expense' do
    let!(:receipt) { create(:receipt, user: user) }
    let!(:expense) { create(:expense, user: user) }

    it 'links receipt to expense' do
      patch "/api/v1/receipts/#{receipt.id}/link_to_expense",
            params: { expense_id: expense.id }.to_json,
            headers: headers

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['linked_to_expense']).to be true
      expect(json['status']).to eq('linked')
    end

    it 'returns error for non-existent expense' do
      patch "/api/v1/receipts/#{receipt.id}/link_to_expense",
            params: { expense_id: 99999 }.to_json,
            headers: headers

      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'GET /api/v1/receipts/stats' do
    let!(:grocery_receipt) { create(:receipt, user: user, category: :groceries, amount: 50) }
    let!(:utility_receipt) { create(:receipt, user: user, category: :utilities, amount: 100) }
    let!(:linked_receipt) { create(:receipt, user: user, expense: create(:expense, user: user)) }

    it 'returns receipt statistics' do
      get '/api/v1/receipts/stats', headers: headers

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)

      expect(json['total_count']).to eq(3)
      expect(json['total_amount']).to eq(150.0)
      expect(json['linked_count']).to eq(1)
      expect(json['unlinked_count']).to eq(2)

      groceries_cat = json['categories'].find { |c| c['name'] == 'groceries' }
      expect(groceries_cat['count']).to eq(1)
      expect(groceries_cat['emoji']).to eq('🛒')
    end
  end
end
