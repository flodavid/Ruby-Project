require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  render_views

  describe "GET #home" do
    it "returns http success" do
#	test "GET #home" do 
      get :home
      expect(response).to have_http_status(:success)
#	  assert_response :success
	  assert_select "title", "Simple App du Tutoriel Ruby on Rails | Accueil"
    end
  end

  describe "GET #contact" do
    it "returns http success" do
#	test "GET #contact" do
      get :contact
      expect(response).to have_http_status(:success)
      assert_select "title", "Simple App du Tutoriel Ruby on Rails | Contact"
    end
  end


  describe "GET #about" do
    it "returns http success" do
#	test "GET #about" do
      get :about
      expect(response).to have_http_status(:success)
      assert_select "title", "Simple App du Tutoriel Ruby on Rails | À Propos"
    end
  end

end
