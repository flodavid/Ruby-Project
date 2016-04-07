require 'rails_helper'

RSpec.describe User, type: :model do

  before(:each) do
    @attr = { :nom => "Example User", :email => "user@example.com" }
  end

  it "should create a new instance with valids attributs" do
    User.create!(@attr)
  end

  it "should exige a name" do
      bad_guy = User.new(@attr.merge(:nom => ""))
      expect(bad_guy).not_to be_valid
  end
  
    it "exige an email address" do
        no_email_user = User.new(@attr.merge(:email => ""))
        expect(no_email_user).not_to be_valid
    end
    
    it "should reject too loog names" do
        long_nom = "a" * 51
        long_nom_user = User.new(@attr.merge(:nom => long_nom))
        expect(long_nom_user).not_to be_valid
    end
    it "should accept a valid email address" do
        adresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
        adresses.each do |address|
            valid_email_user = User.new(@attr.merge(:email => address))
            expect(valid_email_user).to be_valid
        end
    end

    it "should reject a invalid email address" do
        adresses = %w[user@foo,com user_at_foo.org example.user@foo.]
        adresses.each do |address|
        invalid_email_user = User.new(@attr.merge(:email => address))
        expect(invalid_email_user).not_to be_valid
        end
    end
    
  it "should rejet an existing email address" do
    # Place un utilisateur avec un email donné dans la BD.
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    expect(user_with_duplicate_email).not_to be_valid
  end
  
  it "should rejet an existing email address up to case-sensitive" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    expect(user_with_duplicate_email).not_to be_valid
  end
  
end
