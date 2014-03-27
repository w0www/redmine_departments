RedmineApp::Application.routes.draw do
  resources :departments do
    get 'members/autocomplete', :to => 'departments#autocomplete_for_user', :as => :members_autocomplete
    post 'adduser', :to => 'departments#adduser', :as => :add_member
    delete 'removeuser/:user_id', :to => 'departments#removeuser', :as => :remove_member
  end
  match 'issues/:issue_id/departments/:action/:id', :controller => 'departments'
end
