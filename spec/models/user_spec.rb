require 'spec_helper'

describe User do
  before do
    @user = User.new(first_name: "Foo", last_name: "Bar", email: "user@example.com", password: "foobar123" )
  end

  subject { @user }
  	
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  
  it { should be_valid }
  
  describe "when first name is not present" do 
  	before { @user.first_name = "" }
  	it { should_not be_valid }
  end
  
  describe "when last name is not present" do 
  	before { @user.last_name = "" }
  	it { should_not be_valid }
  end
  
  describe "when email is not present" do 
  	before { @user.email = "" }
  	it { should_not be_valid }
  end
  
  describe "when password is not present" do 
  	before { @user.password = "" }
  	it { should_not be_valid }
  end
  
  describe "when email format is invalid" do 
  	it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end
  
  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end
  
  describe "when password is to short" do 
  	before { @user.password = "foo" }
  	it { should_not be_valid }
  end
  
	describe "return value of authenticate method" do
  		before { @user.save }
  		let(:found_user) { User.find_by(email: @user.email) }

	end
		
    describe ".full_name" do
  			it 'should return value full_name' do
             user = User.new(:first_name => 'foo', :last_name => 'bar')
             user.full_name.should == "foo bar"
            end
  			
	   end
	
  
end
