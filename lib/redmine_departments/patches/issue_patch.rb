module RedmineDepartments
  module Patches
    # Patches Redmine's Issues dynamically. Adds a relationship
    # Issue +has_many+ to IssueDepartment
    module IssuePatch
      def self.included(base) # :nodoc:

        base.send(:include, InstanceMethods)

        # Same as typing in the class
        base.class_eval do
          unloadable # Send unloadable so it will not be unloaded in development

          has_and_belongs_to_many :departments, :join_table => "issue_has_departments"
          before_create :default_departments
          alias_method_chain :assignable_users, :filter
        end

      end

      module InstanceMethods
        def assignable_users_with_filter
          assign_filter_allow = Setting.plugin_redmine_departments['use_assign_filter'].to_i == 1
          assign_filter_role = Role.find(Setting.plugin_redmine_departments['role_for_assign_to_all']) if assign_filter_allow
          if assign_filter_allow &&
              tracker.is_in_roadmap && new_record? &&
              !User.current.roles_for_project(project).include?(assign_filter_role)
            users = project.members.select {|m| m.roles.detect {|role| role == assign_filter_role}}.collect {|m| m.user}.sort
            users << author if author
            users.uniq.sort
          else
            assignable_users_without_filter
          end
        end
        
        def default_departments
          if departments.empty? && parent_issue_id && p = Issue.find_by_id(parent_issue_id)
            self.departments = p.departments
          elsif departments.empty?
            self.departments = User.current.departments
          end
        end
      end
    end
  end
end

unless Issue.included_modules.include?(RedmineDepartments::Patches::IssuePatch)
  Issue.send(:include, RedmineDepartments::Patches::IssuePatch)
end
