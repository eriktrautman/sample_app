require 'spec_helper'

describe "StaticPages" do

  	#The HOME page existence test
  	describe "Home Page" do
    	it "should have the h1 'Sample App'" do
	    	visit '/static_pages/home'
	    	page.should have_selector('h1', 
	    			:text=>'Sample App')
    	end 
  	  	it "should have the right title" do
	  		visit '/static_pages/home'
	  		page.should have_selector('title', 
	  			:text => "Ruby on Rails Tutorial Sample App | Home")
  		end
  	end

  	#The HELP page existence test
  	describe "Help Page" do
	  	it "should have the h1 'Help'" do
	  		visit '/static_pages/help'
	  		page.should have_selector('h1', :text => 'Help')
	  	end
  		it "should have the right title" do
	  		visit '/static_pages/help'
	  		page.should have_selector('title', 
	  			:text => "Ruby on Rails Tutorial Sample App | Help")
  		end
  	end

  	#The ABOUT page existence test
    describe "About Page" do
  		it "should have the h1 'About Us'" do
  			visit '/static_pages/about'
  			page.should have_selector('h1', :text=>'About Us')
  		end
  		it "should have the right title" do
	  		visit '/static_pages/about'
	  		page.should have_selector('title', 
	  			:text => "Ruby on Rails Tutorial Sample App | About Us")
  		end
  	end

end
