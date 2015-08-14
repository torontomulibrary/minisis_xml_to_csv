# FindaidGroup
class FindaidGroup
  include SAXMachine

  element :FINDAID
  element :FINDAIDLINK
  element :FINDAID_URL

  # NB: links and URLs may be to old files, but we keep them "just in case"
  def to_s
    self.class.column_names.map { |col| send(col) }.compact.uniq.join("\n")
  end
end
