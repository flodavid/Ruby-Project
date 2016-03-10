require 'rails_helper'

RSpec.describe "LayoutLinks", type: :request do

  describe "GET /layout_links" do

	  it "should find a home webpage at '/'" do
		get 'home'
		assert_select 'title', :content => "Accueil"
	  end

	  it "should find a Contact webpage at '/contact'" do
		get '/contact'
		 assert_select 'title', :content => "Contact"
	  end

	  it "should have an À Propos webpage at '/about'" do
		get "about"
		assert_select 'title', :content => "À Propos"
	  end

	  it "should find a Help webpage at  '/help'" do
		get "/help"
		expect(response).to have_selector('title', :content => "Aide")
	  end

  end
end
