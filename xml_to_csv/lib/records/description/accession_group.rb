# AccessionGroup
class AccessionGroup
  include SAXMachine

  element :D_ACCNO
  element :PROCESSED

  def to_s
    self.class.column_names.map { |col| send(col) }.compact.join('|')
  end
end
