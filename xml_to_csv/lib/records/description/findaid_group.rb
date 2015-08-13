# FindaidGroup
class FindaidGroup
  include SAXMachine

  element :FINDAID
  element :FINDAIDLINK
  element :FINDAID_URL

  def to_s
    self.class.column_names.map { |col| send(col) }.compact.uniq.join('xxx') # FIXME
  end
end
