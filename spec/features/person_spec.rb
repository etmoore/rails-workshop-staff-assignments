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
    fill_in 'Title', with: "Dr."
    fill_in 'First name', with: 'Funken'
    fill_in 'Last name', with: 'Stein'
    click_on 'Update Person'

    within '.table' do
      expect(page).to have_content('Dr. Funken Stein')
    end
  end

  scenario "Users must enter a title/last_name or first_name/last_name" do
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
    fill_in 'Title', with: ''
    fill_in 'First name', with: ''
    fill_in 'Last name', with:  'Stein'
    click_on 'Update Person'

    expect(page).to have_content('Title or First name must be entered')

  end

  scenario "Users must enter a first name or title when editing a person" do
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
    fill_in 'Title', with: ''
    fill_in 'First name', with: ''
    fill_in 'Last name', with:  'Stein'
    click_on 'Update Person'

    expect(page).to have_content('Title or First name must be entered')

  end

  scenario "Users must enter a first name or title when creating a person" do
    create_user email: "user@example.com"

    visit root_path
    click_on "Login"

    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"

    click_on 'New Person'
    fill_in 'Title', with: ''
    fill_in 'First name', with: ''
    fill_in 'Last name', with:  'Stein'
    click_on 'Create Person'

    expect(page).to have_content('Title or First name must be entered')

  end

  scenario "Users can assign people to locations" do
    create_user email: "user@example.com"
    person = create_person
    location = create_location name: "Northwest"

    visit root_path
    click_on "Login"

    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"

    click_on person.full_name

    click_on "+ Add Location"

    expect(page).to have_content('Assign #{person.full_name} to a location')
    select "Northwest", from: "assignment_location"

    fill_in "Role", with: "Boss Man"
    click_on 'Assign'

    within '.page-header' do
      expect(page).to have_content(Person.full_name)
    end

    within '.table' do
      expect(page).to have_content("Northwest")
      expect(page).to have_content("Boss Man")
    end

  end

end
