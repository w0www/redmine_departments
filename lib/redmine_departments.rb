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
  
  # Redmine Departments Patches
  require_dependency 'redmine_departments/patches/issue_patch'
  require_dependency 'redmine_departments/patches/application_controller_patch'
  require_dependency 'redmine_departments/patches/query_patch'
  require_dependency 'redmine_departments/patches/user_patch'

  # Redmine Departments Patches
  require_dependency 'redmine_departments/hooks/add_department_field'
end