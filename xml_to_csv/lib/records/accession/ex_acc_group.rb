class ExAccGroup
  include SAXMachine

  element :EX_ACC_DATE
  element :EX_ACC_NOTES

  def to_s
    return self.class.column_names.map { |col| send(col) }.compact.join("|")
  end
end  