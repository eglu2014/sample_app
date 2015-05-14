require 'spec_helper'

describe "Static pages" do

let(:base_title) { "Ruby on Rails Tutorial Sample App" }

subject { page }

#.................................................................

    describe "Home page" do
        before {visit root_path}
        it { should have_content('Sample App') }
        it { should have_title(full_title('')) }
        it { should_not have_title('| Home') }

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
                    expect(page).to have_selector("li##{item.id}", text: item.content)
                end
            end
        end
    
    end #describe "Home page" 

#.................................................................
  describe "Help page" do

    before {visit help_path}

    it { should have_content('Help')}
    it { should have_title(full_title("Help")) }
    
  end
#.................................................................
describe "About Us page" do

    before {visit about_path}

    it { should have_content('About Us') }
    it { should have_title(full_title('About Us')) }    

  end
#.................................................................
describe "Contacts page" do

  before { visit contacts_path }

  #it { should have_content('Contacts') }
  it { should have_selector('h1', text:'Contacts') }
  it { should have_title(full_title('Contacts')) }
  
end
#.................................................................

end