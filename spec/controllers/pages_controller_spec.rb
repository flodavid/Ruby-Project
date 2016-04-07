require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  render_views

# Old way
#  before(:each) do
#	@base_title = "Simple App du Tutoriel Ruby on Rails"
#  end

# New one (@base_title + "<TXT>" has to be replace by " #{@base_title} <TXT"
  def setup
    @base_title = "Ruby on Rails Tutorial Sample App"
  end

  describe "GET #home" do
    it "returns http success" do
#	test "GET #home" do
      get :home
	  assert_response :success
#      expect(response).to have_http_status(:success)
	end

    it "have good title" do
    	get :home
    	assert_select "title", :content => "#{@base_title} | Accueil"
#		response.should have_selector("title",
#                    :content => "Simple App du Tutoriel Ruby on Rails | Accueil")
    end
  end

  describe "GET #contact" do
    it "returns http success" do
      get :contact
	  assert_response :success
	end

    it "have good title" do
	  get :contact
      assert_select "title", :content => "#{@base_title} | Contact"
    end
  end


  describe "GET #about" do
    it "returns http success" do
      get :about
	  assert_response :success
	end

    it "have good title" do
    	get :about
	    assert_select "title", :content => "#{@base_title} | À Propos"
    end
  end

end
