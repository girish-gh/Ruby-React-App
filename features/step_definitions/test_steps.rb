require 'securerandom'

first_random = SecureRandom.hex.to_s
second_random = SecureRandom.hex.to_s


#Navigate to google.co.uk
Given(/^I am on the Google homepage$/) do
    visit 'https://www.google.co.uk/'
end
#Write "yahoo" search text to the search bar  
When(/^I will search for "([^"]*)"$/) do |searchText|
    fill_in 'lst-ib', :with => searchText
end
#In the current page, we should see "yahoo" text
Then(/^I should see "([^"]*)"$/) do |expectedText|
    page.should have_content(expectedText)
end
#Click the yahoo link 
Then(/^I will click the yahoo link$/) do
    click_link('Yahoo')
end
#Wait 10 seconds statically to see yahoo website
Then(/^I will wait for (\d+) seconds$/) do |waitTime|
    sleep (waitTime.to_i)
end