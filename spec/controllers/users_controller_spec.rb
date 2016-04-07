require 'rails_helper'

RSpec.describe UsersController, type: :controller do
	render_views

  describe "GET 'show'" do

        before(:each) do
            @user = FactoryGirl.create(:user)
        end

        it "should success" do
            get :show, :id => @user
            expect(response).to be_success
        end

        it "should find right user" do
            get :show, :id => @user
            expect(assigns(:user)).to be == @user
        end
        it "devrait avoir le bon titre" do
            get :show, :id => @user
            assert_select "title", :content => @user.nom
        end

        it "should include user's name" do
            get :show, :id => @user
            assert_select "h1", :content => @user.nom
        end

        it "should have a profile picture" do
            get :show, :id => @user
            assert_select "h1>img", :class => "gravatar"
        end
    end # fin describe GET show

    describe "GET 'new'" do

        it "returns http success" do
            get :new
            expect(response).to have_http_status(:success)
        end

        it "should have adequate title" do
            get :new
            assert_select "title", :content => "Inscription"
        end

    end # fin describe GET #new


	  describe "POST 'create'" do

	    describe "fail" do

	      before(:each) do
	        	@attr = { :nom => "", :email => "", :password => "",
	                  :password_confirmation => "" }
	      end

	      it "should not create user" do
	        	lambda do
	          		post :create, :user => @attr
	        	end.should_not change(User, :count)
	      end

	      it "should have right title" do
		        post :create, :user => @attr
		        assert_select "title", :content => "Inscription"
	      end

	      it "should render page 'new'" do
		        post :create, :user => @attr
		        expect(response).to render_template('new')
	      end
	    end # fin describe fail

	    describe "success" do

	      before(:each) do
	        @attr = { :nom => "New User", :email => "user@example.com",
	                  :password => "foobar", :password_confirmation => "foobar" }
	      end

	      it "should create new user" do
	        lambda do
	          	post :create, :user => @attr
	        end.should change(User, :count).by(1)
	      end

	      it "should redirect to user's page" do
	        post :create, :user => @attr
	        expect(response).to redirect_to(user_path(assigns(:user)))
	      end

				it "devrait avoir un message de bienvenue" do
	        post :create, :user => @attr
	        expect(flash[:success]).to =~ /Bienvenue dans l'Application Exemple/i
	      end

	    end # fin describe success

	  end # fin describe POST create

end
