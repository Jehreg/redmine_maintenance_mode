module MaintenanceMode
  def self.included(base)
    base.class_eval do
      unloadable
      prepend_before_filter(:show_maintenance_mode_page)

      def show_maintenance_mode_page
        unless User.current.admin?
          render :text => "The IRCan project management site is under maintenance between 17:00 and 19:00 July 7th, 2010.\n De 17:00 a 19:00 le 7 Juillet 2010, est une periode d'entretien pour le site d'administration de projets du RICan. "
          return false
        end
      end
    end
  end
end


# Patches to the Redmine core.
require 'dispatcher'

Dispatcher.to_prepare do
  require_dependency 'application_controller'
  ApplicationController.send(:include, MaintenanceMode)
end
