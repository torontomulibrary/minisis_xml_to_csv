# Availability
class Availability
  include SAXMachine

  element :OTHER_FORMATS
  element :CALL_NO

  def to_s
    self.class.column_names.map { |col| send(col) }.compact.join('|')
  end
end
