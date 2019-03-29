Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'hubspots/cooperation', to: 'hubspots#cooperation'
  get 'hubspots/get_contact_properties', to: 'hubspots#get_contact_properties'
  get 'hubspots/show_contact_properties', to: 'hubspots#show_contact_properties'
end
