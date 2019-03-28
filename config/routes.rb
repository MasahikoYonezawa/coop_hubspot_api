Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get   'hubspots/cooperation', to: 'hubspots#cooperation'
  post 'hubspots/post_contact_properties', to: 'hubspots#post_contact_properties'
end
