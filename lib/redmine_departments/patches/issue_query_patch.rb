module RedmineDepartments
  module Patches
    # Patches Redmine's Queries dynamically, adding the Deliverable
    # to the available query columns
    module IssueQueryPatch
      def self.included(base) # :nodoc:
        base.send(:include, InstanceMethods)

        # Same as typing in the class
        base.class_eval do
          unloadable # Send unloadable so it will not be unloaded in development
          #base.add_available_column(QueryColumn.new(:deliverable_subject, :sortable => "#{Deliverable.table_name}.subject"))

          alias_method_chain :initialize_available_filters, :departments
        end

      end

      module InstanceMethods

        def sql_for_department_id_field(field, operator, value)
          db_table = 'issue_has_departments'
          "#{Issue.table_name}.id #{ operator == '=' ? 'IN' : 'NOT IN' } (SELECT #{db_table}.issue_id FROM #{db_table} WHERE " +
            sql_for_field(field, '=', value, db_table, 'department_id') + ')'
        end

        # Wrapper around the +available_filters+ to add a new Departments filter
        def initialize_available_filters_with_departments
          initialize_available_filters_without_departments
          add_available_filter "department_id",
            :type => :list_optional, :values => Department.all().collect { |d| [d.name, d.id.to_s] }
        end
      end
    end
  end
end

unless IssueQuery.included_modules.include?(RedmineDepartments::Patches::IssueQueryPatch)
  IssueQuery.send(:include, RedmineDepartments::Patches::IssueQueryPatch)
end
