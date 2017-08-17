module ComactionsHelper
  def idtype(ev)
    letter = label_type = ''
    if ev.action_type == Comaction::CLIENT_TYPE
      label_type = 'label-primary small_label '
      letter = 'C'
    elsif ev.action_type == Comaction::APPLY_TYPE
      label_type = 'label-info small_label '
      letter = 'F'
    elsif ev.action_type == Comaction::APPLY_CUSTOMER_TYPE
      label_type = 'label-danger small_label '
      letter = 'R'
    elsif ev.action_type == Comaction::EXPLORATION_TYPE
      label_type = 'label-default small_label '
      letter = 'E'
    end
    "<p class='label label-mini #{label_type}'> #{letter} </p>".html_safe
  end

  def background_style (ev)
    style = "status-frame "
    style +=  case ev.action_type.to_s
      when Comaction::CLIENT_TYPE then "client-appointment"
      when Comaction::APPLY_TYPE then "applier-appointment"
      when Comaction::APPLY_CUSTOMER_TYPE then "applier-client-appointment"
      when Comaction::EXPLORATION_TYPE then "exploration-appointment"
      else ""
    end
  end

  def getComactionTitle(c)
    "<strong>#{c.person.full_name}</strong><br>#{c.action_type} [#{c.status}] "
  end

  def getComactionDetails(c)
    "<i class='fa fa-bookmark-o '></i> : [#{c.mission.status}] #{c.mission.name} <br><i class='fa fa-building-o '></i> : <strong>#{c.mission.company.company_name}</strong>"
  end

  def button_filters(cal)
    r=''
    Comaction::STATUSES.each { |status|
      if cal.to_i == 1
        r += link_to status, comactions_path( :filter => Comaction::STATUS_RELATED[status], :v => 'calendar_view'), class: "btn btn-success"
      else
        r += link_to status, comactions_path(:filter => Comaction::STATUS_RELATED[status], :v => 'table_view'), class: "btn btn-success"
      end
    }
    r.html_safe
  end
end
