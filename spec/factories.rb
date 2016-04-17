# En utilisant le symbole ':user', nous faisons que
# Factory Girl simule un modèle User.
FactoryGirl.define do
    factory :user do |user|
        user.nom                  "Florian DAViD"
        user.email                 "foomail@example.com"
        user.password              "foobar"
        user.password_confirmation "foobar"
    end
end