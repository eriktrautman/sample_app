require 'spec_helper'

describe "StaticPages" do

	# Define a variable for our base title to demonstrate the LET command
	let(:base_title) {"Ruby on Rails Tutorial Sample App"}

  	# The HOME page existence test
  	subject { page }

  	describe "Home Page" do
  		before { visit root_path }
	   	it { should have_selector('h1', text:'Sample App') } # this is an example of one collapsed test syntax
	  	it { should have_selector('title', text: full_title('')) }
	  	it { should_not have_selector('title', text: "| Home")}

      describe "for signed-in users" do
        let(:user) { FactoryGirl.create(:user) }
        before do
          FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
          FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
          sign_in user
          visit root_path
        end

        it "should render the user's feed" do
          user.feed.each do |item|
            page.should have_selector("li##{item.id}", text: item.content)
          end
        end
      end
  	end

  	# The HELP page existence test... uses the old, windy style of syntax for reference purposes
  	describe "Help Page" do
  		before { visit help_path }
	  	it "should have the h1 'Help'" do
	  		page.should have_selector('h1', :text => 'Help')
	  	end
  		it "should have the right title" do
	  		page.should have_selector('title', 
	  			:text => "#{base_title} | Help")
  		end
  	end

  	# The ABOUT page existence test... uses the old, windy style of syntax for reference purposes
    describe "About Page" do
    	before { visit about_path }
  		it "should have the h1 'About Us'" do
  			page.should have_selector('h1', :text=>'About Us')
  		end
  		it "should have the right title" do
	  		page.should have_selector('title', 
	  			:text => "#{base_title} | About Us")
  		end
  	end

  	# The CONTACT page existence test... uses the old, windy style of syntax for reference purposes
    describe "Contact Page" do
    	before { visit contact_path }
  		it "should have the h1 'Contact Me'" do
  			visit contact_path
  			page.should have_selector('h1', text:'Contact Me')
  		end
  		it "should have the right title" do
	  		visit contact_path
	  		page.should have_selector('title', 
	  			:text => "#{base_title} | Contact")
  		end
  	end

end
