class ControllingGroup
  include SAXMachine

  element :DATE_CONTROLLED
  element :CONT_AGENCY

  def to_s
    return self.class.column_names.map { |col| send(col) }.compact.join("|")
  end
end
