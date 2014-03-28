# Set up autoload of patches
def apply_patch(&block)
  ActionDispatch::Callbacks.to_prepare(&block)
end

apply_patch do
  ## Redmine dependencies
  require_dependency 'issue'
  require_dependency 'application_controller'
  require_dependency 'query'
  require_dependency 'user'
  require_dependency 'redmine/helpers/time_report'
  
  # Redmine Departments Patches
  require_dependency 'redmine_departments/patches/issue_patch'
  require_dependency 'redmine_departments/patches/application_controller_patch'
  require_dependency 'redmine_departments/patches/issue_query_patch'
  require_dependency 'redmine_departments/patches/user_patch'
  require_dependency 'redmine_departments/patches/time_report_patch'

  # Redmine Departments Patches
  require_dependency 'redmine_departments/hooks/add_department_field'
end