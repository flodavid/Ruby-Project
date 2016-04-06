require 'rails_helper'

RSpec.describe UsersController, type: :controller do
	render_views

  describe "GET #new" do
    it "returns http success" do
      	get :new
      	expect(response).to have_http_status(:success)
    end

    it "should have adequate title" do
      	get 'new'
    	assert_select "title", :content => "Inscription"
    end

  end

end
