# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe User do
  
  # runs this code before each example
  before do 
  	@user = User.new( name:"Example User", email:"user@example.com", 
  						password:"foobar", password_confirmation:"foobar" )
  end
  
  # makes @user the default subject for our tests
  subject { @user }

  it { should respond_to(:name)}
  it { should respond_to(:email)}
  it { should respond_to(:password_digest)}
  it { should respond_to(:password)}
  it { should respond_to(:password_confirmation)}
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate)}

  it { should be_valid } # just a sanity check for the @user object's validity

  # test that a blank user name fails
  describe "when name is not present" do	
  	before { @user.name = " " }
  	it { should_not be_valid }
  end

  # test that a blank email fails
    describe "when email is not present" do	
  	before { @user.email = " " }
  	it { should_not be_valid }
  end

  # test that the name can't be too long (51 chars)
  describe "when name is too long" do	
  	before { @user.name = "a" * 51 }
  	it { should_not be_valid }
  end

  # test that the email format is INvalid
  describe "when email format is invalid" do
  	it "should be invalid" do
  		addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
  		addresses.each do |invalid_address|
  			@user.email = invalid_address
  			@user.should_not be_valid
  		end
  	end	
  end

  # test that the email format IS valid
  describe "when email format IS valid" do
  	it "should be valid" do
  		addresses = %w[user@foo.COM A_US-ER@f.b.org frst.1st@foo.jp a+b@baz.cn]
  		addresses.each do |valid_address|
  			@user.email = valid_address
  			@user.should be_valid
  		end
  	end	
  end

  # test for email address uniqueness
  describe "when email address is already taken" do
  	before do
  		user_with_same_email = @user.dup
  		user_with_same_email.email = @user.email.upcase
  		user_with_same_email.save
  	end

  	it { should_not be_valid }
  end

  # test that both password and confirmation are present // note the double assignment reading right to left
  describe "when password is not present" do
  	before {@user.password = @user.password_confirmation = " "}
  	it { should_not be_valid }
  end

  # test to fail when password and confirmation both mismatch
  describe "when password doesn't match confirmation" do
  	before { @user.password_confirmation = "mismatch" }
  	it { should_not be_valid }
  end

  # test if password confirmation is nil (can't happen via web, but can from console)
  describe "when password confirmation is nil" do
  	before { @user.password_confirmation = nil }
  	it { should_not be_valid }
  end

  describe "return value of authenticate method" do
  	before { @user.save }
  	let(:found_user) { User.find_by_email(@user.email)}

  	describe "with valid password" do
  		it { should == found_user.authenticate(@user.password)}
  	end

  	describe "with invalid password" do
  		let(:user_for_invalid_password) { found_user.authenticate("invalid")}

  		it { should_not == user_for_invalid_password }
  		specify { user_for_invalid_password.should be_false }
  	end
  end

  describe "with a password that's too short" do
  	before { @user.password = @user.password_confirmation = "a" * 5 }
  	it { should be_invalid }
  end

  describe "remember token" do
    before { @user.save }
    its(:remember_token) {should_not be_blank }
  end


end


