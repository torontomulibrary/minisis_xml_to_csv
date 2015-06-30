class OfficeOfOrigin
  include SAXMachine

  element :OFFICE_AB

  def to_s
    return self.class.column_names.map { |col| send(col) }.compact.join("|")
  end
end
