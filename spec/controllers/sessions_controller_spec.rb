require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
    render_views

  describe "GET #new" do
  
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
    
    
    it "should have good title" do
      get :new
      assert_select "title", :content => "S'identifier"
    end
    
  end # fin GET #new
  
  describe "POST 'create'" do

    describe "invalid signin" do

      before(:each) do
        @attr = { :email => "email@example.com", :password => "invalid" }
      end

      it "should re-render the new page" do
        post :create, :session => @attr
        expect(response).to render_template('new')
      end

      it "should have good title" do
        post :create, :session => @attr
        assert_select "title", :content => "S'identifier"
      end

      it "should have a message flash.now" do
        post :create, :session => @attr
        expect(flash.now[:error]).to be =~ /invalid/i
      end
      
    end # fin describe invalid signin
    
    describe "with valids email and password" do

      before(:each) do
        @user = FactoryGirl.create(:user)
        @attr = { :email => @user.email, :password => @user.password }
      end

      it "should authenticate user" do
        post :create, :session => @attr
        expect(controller.current_user).to be == @user
        expect(controller).to be_signed_in
      end

      it "should redirect to user's display page" do
        post :create, :session => @attr
        expect(response).to redirect_to(user_path(@user))
      end
    end # fin describe with valids email and password
    
  end # fin describe POST create
  
  describe "DELETE 'destroy'" do

    it "should disconnect an user" do
      test_sign_in(FactoryGirl.create(:user))
      delete :destroy
      expect(controller).not_to be_signed_in
      expect(response).to redirect_to(root_path)
    end
  end

end
