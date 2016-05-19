module RedmineDepartments
  module Hooks
    class AddDepartmentField < Redmine::Hook::ViewListener

      # Renders the Departments
      #
      # Context:
      # * :issue => Issue being rendered
      #
      def view_issues_form_details_bottom(context = {})
        if has_permission?(context)
          context[:controller].send(:render_to_string, {
            :partial => "issues/new/form",
            :locals => context
          })
        else
          return ''
        end
      end

      def view_issues_bulk_edit_details_bottom(context = {})
        if has_permission?(context)
          context[:controller].send(:render_to_string, {
            :partial => "issues/new/form",
            :locals => context
          })
        else
          return ''
        end
      end

      def view_issues_show_description_bottom(context = {})
        if has_permission?(context)
          context[:controller].send(:render_to_string, {
            :partial => "issues/departments",
            :locals => context
          })
        else
          return ''
        end
      end

      def controller_issues_new_before_save(context = {})
        set_departments_on_issue(context)
      end

      def controller_issues_edit_before_save(context = {})
        set_departments_on_issue(context)
      end

      def controller_issues_bulk_edit_before_save(context = {})
        set_departments_on_issue(context)
      end

      def view_layouts_base_html_head(context = {})
        stylesheet_link_tag 'departments', :plugin => 'redmine_departments'
      end

    private
      def protect_against_forgery?
        false
      end

      def has_permission?(context)
        context[:project] && context[:project].module_enabled?('departments') && User.current.allowed_to?(:view_departments, context[:project])
      end

      def set_departments_on_issue(context)
        if context[:params] && context[:params][:issue] && context[:params][:issue][:department_ids] != [""]
          # Por alguna razon cuando llega a este punto llega siempre un array [""] y luego el resto. 
          # Tenemos que quitar ese primer array.
          array_oficinas = context[:params][:issue][:department_ids] - [""]
          # Iteramos por el array de oficinas y las introducimos a los departamentos de la issue
          for o in array_oficinas
            context[:issue].departments << Department.find(o.to_i)
          end
        end
        return ''
      end
    end
  end
end
