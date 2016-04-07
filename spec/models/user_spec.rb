require 'rails_helper'

RSpec.describe User, type: :model do

    before(:each) do
        @attr = {
        :nom => "Utilisateur exemple",
        :email => "user@example.com",
        :password => "foobar",
        :password_confirmation => "foobar"
        }
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


    describe "password validations" do
             
        before(:each) do
            @user = User.create!(@attr)
        end
    
        # Password validation
        it "should have password (nonblank)" do
            blank_password_user = User.new(@attr.merge(:password => " " * 6))
            expect(blank_password_user).not_to be_valid
        end

        it "should have password with minimum length" do
            bad_length_password_user = User.new(@attr.merge(:password => "a" * 5))
            expect(bad_length_password_user).not_to be_valid
        end
            
        # Others password validations
        it "should ask a password" do
            expect(User.new(@attr.merge(:password => "", :password_confirmation => ""))).not_to be_valid
        end

        it "should ask for a password confirmation" do
            expect(User.new(@attr.merge(:password => "", :password_confirmation => "invalid"))).not_to be_valid
        end

        it "reject too long passwords" do
            long = "a" * 41
            hash = @attr.merge(:password => long, :password_confirmation => long)
            expect(User.new(hash)).not_to be_valid
        end
    end # fin password validations
        
    describe "password encryption" do

        before(:each) do
            @user = User.create!(@attr)
        end
            
        it "should have a crypted attribut password" do
            expect(@user).to respond_to(:encrypted_password)
        end

        it "should define an encrypted password" do
			expect(@user.encrypted_password).not_to be_blank
		end

        describe "method has_password?" do

            it "should return true if passwords are identicals" do
                expect(@user.has_password?(@attr[:password])).to be_truthy
            end    

            it "should return false if passwords are not identicals" do
                expect(@user.has_password?("invalide")).to be_falsey
            end
        end # Fin method has_password?
        
        describe "authenticate method" do

            it "should return nul not any matches email/password" do
                wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
                expect(wrong_password_user).to be_nil
            end

            it "devrait retourner nil quand un email ne correspond à aucun utilisateur" do
                nonexistent_user = User.authenticate("bar@foo.com", @attr[:password])
                expect(nonexistent_user).to be_nil
            end

            it "devrait retourner l'utilisateur si email/mot de passe correspondent" do
                matching_user = User.authenticate(@attr[:email], @attr[:password])
                expect(matching_user).to be == @user
            end
         end # fin authenticate method
        
    end #fin password encryption
end
