require 'rails_helper'

RSpec.describe 'Items API' do
    let(:user) { create(:user) }
    let!(:todo) { create(:todo) }
    let!(:items) { create_list(:item, 20, todo_id: todo.id) }
    let(:todo_id) { todo.id }
    let(:id) { items.first.id }
    let(:headers) { valid_headers }

    describe 'GET /todos/:todo_id/items' do
        before { get "/todos/#{todo_id}/items", params: {}, headers: headers }

        context 'when todo exists' do
            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end

            it 'returns all the todo items for that todo' do
                expect(json.size).to eq(20)
            end
        end

        context 'when todo does not exisit' do
            let(:todo_id) { 0 }

            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end

            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find Todo/)
            end
        end
    end

    describe 'GET /todos/:todo_id/items/:id' do
        before { get "/todos/#{todo_id}/items/#{id}", params: {}, headers: headers }

        context 'when todo item exists' do
            it 'returns status code of 200' do
                expect(response).to have_http_status(200)
            end

            it 'returns the item' do
                expect(json['id']).to eq(id)
            end
        end

        context 'when the todo item does not exist' do
            let(:id) { 0 }

            it 'returns status code of 404' do
                expect(response).to have_http_status(404)
            end

            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find Item/)
            end
        end
    end

    describe 'POST /todos/:todo_id/items' do
        let(:valid_attributes) { { name: 'Visit Narnia', done: false } }

        context 'when the request attributes are valid' do
            before do
                post "/todos/#{todo_id}/items", params: valid_attributes, headers: headers
            end

            it 'returns the status code of 201' do
                expect(response).to have_http_status(201)
            end
        end

        context 'when the request is invalid' do
            before { post "/todos/#{todo_id}/items", params: {}, headers: headers }

            it 'returns a status code of 422' do
                expect(response).to have_http_status(422)
            end

            it 'returns a failure message' do
                expect(response.body).to match(/Validation failed: Name can't be blank/)
            end
        end
    end

    describe 'PUT /todos/:todo_id/items/:id' do
        let (:valid_attributes) { { name: 'Batman' } }
        
        before do
            put "/todos/#{todo_id}/items/#{id}", params: valid_attributes, headers: headers
        end
        
        context 'when an item exists' do
            it 'returns a status code of 204' do
                expect(response).to have_http_status(204)
            end

            it 'updates the item' do
                updated_item = Item.find(id)
                expect(updated_item.name).to match(/Batman/)
            end
        end

        context 'when the item does not exist' do
            let(:id) { 0 }

            it 'returns status code of 404' do
                expect(response).to have_http_status(404)
            end

            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find Item/)
            end
        end
    end

    describe 'DELETE  /todos/todos/:todo_id/items/:id' do
        before { delete "/todos/#{todo_id}/items/#{id}", params: {}, headers: headers }

        it 'returns status code 204' do
            expect(response).to have_http_status(204)
        end
    end
end