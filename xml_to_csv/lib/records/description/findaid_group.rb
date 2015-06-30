class FindaidGroup
  include SAXMachine

  element :FINDAID
  element :FINDAIDLINK
  element :FINDAID_URL

  def to_s
    return self.class.column_names.map { |col| send(col) }.compact.join("|")
  end
end