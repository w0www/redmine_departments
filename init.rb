require 'redmine'

require 'redmine_departments'

Redmine::Plugin.register :redmine_departments do
  name 'Redmine Departments plugin'
  author 'Nick Peelman, Aleksandr Palyan and Imanol Alvarez'
  description 'Departments/Offices Plugin.  Icons are from the Silk collection, by FamFamFam'
  version '1.0.1'
  settings({
    :partial => 'settings/redmine_departments_settings',
    :default => {
      :role_for_assign_to_all => "3",
      :use_assign_filter => "0"
    }
  }) 
    
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
