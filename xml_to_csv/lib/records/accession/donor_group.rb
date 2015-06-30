class DonorGroup
  include SAXMachine

  element :ORGANIZATION
  element :INDIVIDUAL
  element :CONTACT

  def to_s
    return self.class.column_names.map { |col| send(col) }.compact.join("|")
  end
end