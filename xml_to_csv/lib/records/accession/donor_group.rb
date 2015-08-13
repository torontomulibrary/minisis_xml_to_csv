# DonorGroup
class DonorGroup
  include SAXMachine

  element :INDIVIDUAL
  element :CONTACT
  element :ORGANIZATION

  def to_s
    self.class.column_names.map { |col| send(col) }.compact.uniq.join(' - ')
  end
end
