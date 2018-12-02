class V2::TodosController < ApplicationController

    # GET /todos
    def index
        json_response({message:'hi, you are talking to the in progress version'})
    end
end
