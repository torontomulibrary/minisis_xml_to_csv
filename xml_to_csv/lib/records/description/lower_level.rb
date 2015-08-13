# LowerLevel
class LowerLevel
  include SAXMachine

  element :LOWER_CODE
  element :LOWER_TITLE
  element :LOWER_TYPE

  def to_s
    self.class.column_names.map { |col| send(col) }.compact.uniq.join('xxx') # FIXME
  end
end
