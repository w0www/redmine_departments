class IssueHasDepartment < ActiveRecord::Base
  belongs_to :issues
  belongs_to :departments
  self.table_name = 'issue_has_departments'
end
