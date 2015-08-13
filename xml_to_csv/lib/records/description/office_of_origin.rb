# OfficeOfOrigin
class OfficeOfOrigin
  include SAXMachine

  element :OFFICE_AB

  def to_s
    self.class.column_names.map { |col| send(col) }.compact.uniq.join('xxx') # FIXME
  end
end
