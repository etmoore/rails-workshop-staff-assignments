require 'rails_helper'
require 'capybara/rails'

feature 'Person' do

  scenario 'Users can see a show page' do
    create_user email: "user@example.com"
    person = create_person

    visit root_path
    click_on "Login"

    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"

    click_on person.full_name
    within 'h1' do
      expect(page).to have_content(person.full_name)
    end
  end

  scenario "Users can edit people" do
    create_user email: "user@example.com"
    person = create_person

    visit root_path
    click_on "Login"

    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"

    click_on person.full_name
    within 'h1' do
      expect(page).to have_content(person.full_name)
    end

    click_on 'Edit'
    fill_in 'Title', :with => "Dr."
    fill_in 'First name', :with => 'Funken'
    fill_in 'Last name', :with => 'Stein'
    click_on 'Update User'

    within '.table' do
      expect(page).to have_content('Dr. Funken Stein')
    end
  end

end
