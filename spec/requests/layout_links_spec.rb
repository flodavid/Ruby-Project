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
    
	describe "when not identified" do
		it "should have a connexion link" do
			visit root_path
			expect(page).to have_link("Connexion")
		end
	end # fin when not identified
	
	describe "when identified" do
		before(:each) do
		  @user = FactoryGirl.create(:user)
		  visit signin_path
		  fill_in "session_email",    		:with => @user.email
		  fill_in "session_password", 		:with => @user.password
		  click_button "S'identifier"
		end

		it "should have a disconnection link" do
		  visit root_path
		  expect(page).to have_link("Déconnexion")
		end
		
        it "should have a link to profile" do
	      visit root_path
		  expect(page).to have_link("Profil")
        end
    end # fin when identified

  end # fin GET /LayoutLinks
end
