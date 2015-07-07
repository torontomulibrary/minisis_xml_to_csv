# DespatchGroup
class DespatchGroup
  include SAXMachine

  element :DESPATCHER
  element :REASON_DESPATCH
  element :DISPOSAL_DATE
  element :DEACCESSION_NOTE
  element :DEACC_DOC_GRP
  element :APPROVED_BY
  element :APPROVED_DATE
  element :LEGAL_RIGHT
  element :DES_REC_BY

  def to_s
    self.class.column_names.map { |col| send(col) }.compact.join('|')
  end
end
