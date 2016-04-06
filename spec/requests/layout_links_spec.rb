require 'rails_helper'

RSpec.describe "LayoutLinks", type: :request do
#  render_views

  describe "GET /layout_links" do

	  it "should find a home webpage at '/'" do
		get '/'
		expect(response.body).to include("Accueil</title>")
	  end

	  it "should find a Contact webpage at '/contact'" do
		get '/contact'
		expect(response.body).to include("Contact</title>")
	  end

	  it "should have an À Propos webpage at '/about'" do
		get '/about'
		expect(response.body).to include("À Propos</title>")
	  end

	  it "should find a Help webpage at  '/help'" do
		get '/help'
		expect(response.body).to include("Aide</title>")
	  end

  end
end
