ActionController::Routing::Routes.draw do |map|
  map.resources :departments
  map.with_options :controller => 'departments' do |departments_routes|
    departments_routes.connect 'issues/:issue_id/departments/:action/:id'
    departments_routes.connect 'departments/:id/:action'
    departments_routes.connect 'departments/:id/:action/:user_id'
  end
end
