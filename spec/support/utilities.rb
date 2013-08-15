include ApplicationHelper

def signin(email, password)
  fill_in "Email",    with: email
  fill_in "Password", with: password
  click_button "Sign in"
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-error', text: message)
  end
end