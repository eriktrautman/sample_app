require 'spec_helper'

describe "StaticPages" do

	# Define a variable for our base title to demonstrate the LET command
	let(:base_title) {"Ruby on Rails Tutorial Sample App"}

  	# The HOME page existence test
  	describe "Home Page" do
    	it "should have the h1 'Sample App'" do
	    	visit '/static_pages/home'
	    	page.should have_selector('h1', 
	    			:text=>'Sample App')
    	end 
  	  	it "should have the right title" do
	  		visit '/static_pages/home'
	  		page.should have_selector('title', 
	  			:text => "#{base_title} | Home")
  		end
  	end

  	# The HELP page existence test
  	describe "Help Page" do
	  	it "should have the h1 'Help'" do
	  		visit '/static_pages/help'
	  		page.should have_selector('h1', :text => 'Help')
	  	end
  		it "should have the right title" do
	  		visit '/static_pages/help'
	  		page.should have_selector('title', 
	  			:text => "#{base_title} | Help")
  		end
  	end

  	# The ABOUT page existence test
    describe "About Page" do
  		it "should have the h1 'About Us'" do
  			visit '/static_pages/about'
  			page.should have_selector('h1', :text=>'About Us')
  		end
  		it "should have the right title" do
	  		visit '/static_pages/about'
	  		page.should have_selector('title', 
	  			:text => "#{base_title} | About Us")
  		end
  	end

  	# The CONTACT page existence test
    describe "Contact Page" do
  		it "should have the h1 'Contact Me'" do
  			visit '/static_pages/contact'
  			page.should have_selector('h1', :text=>'Contact Me')
  		end
  		it "should have the right title" do
	  		visit '/static_pages/contact'
	  		page.should have_selector('title', 
	  			:text => "#{base_title} | Contact")
  		end
  	end

end
