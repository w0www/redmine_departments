RedmineApp::Application.routes.draw do
  resources :departments do
    get 'members/autocomplete', :to => 'departments#autocomplete_for_user', :as => :members_autocomplete
    post 'adduser', :to => 'departments#adduser', :as => :add_member
    delete 'removeuser/:user_id', :to => 'departments#removeuser', :as => :remove_member
  end
  post 'issues/:issue_id/departments', :to => 'departments#addissue', :as => :issue_add_department
  delete 'issues/:issue_id/departments/:department_id' => 'departments#removeissue', :as => :issue_remove_department, :source => 'issue'
  delete 'departments/:department_id/issues/:issue_id' => 'departments#removeissue', :as => :department_remove_issue, :source => 'department'
end
