module RedmineDepartments
  module Patches
    module TimeReportPatch
      def self.included(base) # :nodoc:
        base.send(:include, InstanceMethods)

        # Same as typing in the class
        base.class_eval do
          unloadable # Send unloadable so it will not be unloaded in development

          alias_method_chain :load_available_criteria, :departments
        end

      end

      module InstanceMethods

        def load_available_criteria_with_departments
          load_available_criteria_without_departments
          @available_criteria["department"] = 
            { :sql => "COALESCE(departments.department_id, '')",
              :joins => "LEFT JOIN issue_has_departments departments on departments.issue_id = #{TimeEntry.table_name}.issue_id",
              :klass => Department,
              :label => :field_department
            }
          @available_criteria
        end
      end
    end
  end
end

unless Redmine::Helpers::TimeReport.included_modules.include?(RedmineDepartments::Patches::TimeReportPatch)
  Redmine::Helpers::TimeReport.send(:include, RedmineDepartments::Patches::TimeReportPatch)
end
