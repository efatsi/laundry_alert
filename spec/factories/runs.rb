FactoryGirl.define do
   factory :washer_run, :class => "Run" do
     account
     machine_type "washer"
   end

   factory :dryer_run, :class => "Run" do
     account
     machine_type "dryer"
   end
end
