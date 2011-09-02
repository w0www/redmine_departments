module RedmineDepartments
  # Patches Redmine's Issues dynamically. Adds a relationship
  # Issue +has_many+ to IssueDepartment
  module IssuePatch
    def self.included(base) # :nodoc:

      base.send(:include, InstanceMethods)

      # Same as typing in the class
      base.class_eval do
        unloadable # Send unloadable so it will not be unloaded in development

        has_and_belongs_to_many :departments, :join_table => "issue_has_departments"

        alias_method_chain :assignable_users, :filter
      end
   
    end

    module InstanceMethods
      def assignable_users_with_filter
        if tracker.is_in_roadmap && new_record?
          # fast change for clear user list
          # TODO: move role and tracker to config
          users = project.members.select {|m| m.roles.detect {|role| role.id == 3}}.collect {|m| m.user}.sort
          users << author if author
          users.uniq.sort
        else
          assignable_users_without_filter
        end
      end
    end
  end
end
