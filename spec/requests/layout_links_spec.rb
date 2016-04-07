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

	  it "should find a Help webpage at '/signup'" do
		get '/signup'
		expect(response.body).to include("Inscription</title>")
	  end

	# Tests de vérification du bon fonctionnement des liens
		it "should have the right link on the layout" do
			visit root_path
			click_link "À Propos"
            expect(page).to have_title "À Propos"
			click_link "Aide"
		    expect(page).to have_title "Aide"
			click_link "Contact"
            expect(page).to have_title "Contact"
			click_link "Accueil"
		    expect(page).to have_title "Accueil"
			click_link "S'inscrire !"
			expect(page).to have_title "Inscription"
    end

  end
end
