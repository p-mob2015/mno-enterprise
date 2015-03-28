# Read about factories at https://github.com/thoughtbot/factory_girl

# This is an API resource factory generating a Hash to be used in API stubs
# Use as such: build(:api_user)
# See http://stackoverflow.com/questions/10032760/how-to-define-an-array-hash-in-factory-girl
FactoryGirl.define do
  
  factory :user, class: MnoEnterprise::User do
    sequence(:id)
    name "John"
    surname "Doe"
    sequence(:email) { |n| "john.doe#{n}@maestrano.com" }
    company "Doe Inc."
    phone "449 789 456"
    phone_country_code "AU"
    geo_country_code "AU"
    geo_state_code "NSW"
    geo_city "Sydney"
    
    confirmation_token "wky763pGjtzWR7dP44PD"
    confirmed_at 3.days.ago.iso8601
    
    trait :unconfirmed do
      confirmed_at nil
    end
    
    trait :with_deletion_request do
      #association :deletion_request, strategy: :build
      deletion_request { build(:deletion_request).attributes }
    end
    
    trait :with_organizations do
      #organizations { [build(:organization)] }
      organizations { [build(:organization).attributes] }
    end
    
    # Properly build the resource with Her
    initialize_with { new(attributes).tap { |e| e.clear_attribute_changes! } }
  end
  
  # API Response for user model
  factory :api_user, class: Hash, parent: :user do
    initialize_with { attributes }
  end
end
