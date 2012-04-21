require 'redmine'

require 'dispatcher'
require 'will_paginate'

Dispatcher.to_prepare :redmine_departments do
  require_dependency 'issue'
  # Guards against including the module multiple time (like in tests)
  # and registering multiple callbacks
  Issue.send(:include, RedmineDepartments::IssuePatch) unless Issue.included_modules.include?(RedmineDepartments::IssuePatch)
  ApplicationController.send(:include, RedmineDepartments::ApplicationControllerPatch) unless ApplicationController.included_modules.include?(RedmineDepartments::ApplicationControllerPatch)
  Query.send(:include, RedmineDepartments::QueryPatch) unless Query.included_modules.include? RedmineDepartments::QueryPatch
  User.send(:include, RedmineDepartments::UserPatch) unless User.included_modules.include? RedmineDepartments::UserPatch
end

require_dependency 'departments_show_issue_hook'

Redmine::Plugin.register :redmine_departments do
  name 'Redmine Departments plugin'
  author 'Nick Peelman'
  description 'Departments Plugin for the LSSupport Group.  Icons are from the Silk collection, by FamFamFam'
  version '1.0.0'
  settings :default => {
    :role_for_assign_to_all => "3",
    :use_assign_filter => "0"
  }, :partial => 'settings/redmine_departments_settings'
    
  menu :top_menu, :departments, { :controller => :departments, :action => :index }, :caption => :title_department_plural, :if => Proc.new{ User.current.logged? }
  menu :admin_menu, :departments, {:controller => :departments, :action => :index }, :caption => :title_department_plural
  
  project_module :departments do |map|
    map.permission :view_departments, { :departments => [:index, :show] }
    map.permission :add_departments, { :departments => :new }
    map.permission :edit_departments, { :departments => :edit }
    map.permission :delete_departments, { :departments => :delete }
    map.permission :add_issue_to_department, { :departments => :addissue }
    map.permission :remove_issue_from_department, { :departments => :removeissue }
  end

end
