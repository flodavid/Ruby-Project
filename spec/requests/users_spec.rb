require 'rails_helper'

RSpec.describe "Users", type: :request do
    # describe "GET /users" do
    #     it "works! (now write some real specs)" do
    #         get users_index_path
    #         expect(response).to have_http_status(200)
    #     end
    # end

    describe "signup" do

        describe "failure" do

            it "shouldn't create a new user" do
                lambda do
                    visit signup_path
                    fill_in "Nom",          :with => ""
                    fill_in "Email",        :with => ""
                    fill_in "Mot de passe", :with => ""
                    fill_in "Confirmation", :with => ""
                    click_button "Inscription"
                    #expect(response).to render_template('users/new')
                    #assert_select "div", :id => "error_explanation"
                    expect(page).to have_selector("div#error_explanation")
                end.should_not change(User, :count)
            end # fin shouldn't create new user
        end # fin failure
            
        describe "success" do

            it "should create a new user" do
                lambda do
                    visit signup_path
                    fill_in "Nom",          :with => "Example User"
                    fill_in "Email",        :with => "user@example.com"
                    fill_in "Mot de passe", :with => "foobar"
                    fill_in "Confirmation", :with => "foobar"
                    click_button "Inscription"
                    expect(page).to have_selector("div.alert-success", text: "Bienvenue")                               
                    #assert_select "div.flash.success", :content => "Bienvenue"
                                                    
                    #expect(response).to render_template('users/show')
                end.should change(User, :count).by(1)
            end #fin it should create new user
        end # fin success
        
    end # fin signup
    
    describe "login/logout" do
    
		describe "failure" do
        
			it "should not identify the user" do
				visit signin_path
				fill_in "session_email",    :with => ""
				fill_in "session_password", :with => ""
				click_button "S'identifier"
				expect(response).to have_selector("div.alert.alert-error", :content => "invalide.")
			end
		end # fin failure

		describe "success" do
        
			it "should identify then disconnect the user" do
				user = FactoryGirl.create(:user)
				visit signin_path
				fill_in "session_email",    :with => user.email
				fill_in "session_password", :with => user.password
				click_button "S'identifier"
				expect(controller).to be_signed_in
				click_link "Déconnexion"
                expect(controller).not_to be_signed_in
			end
		end # fin success
    end # fin login/logout
end
