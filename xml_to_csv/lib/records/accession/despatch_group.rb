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
  element :LEGAL_RIGHT # UNMAPPED
  element :DES_REC_BY

  def to_s
    value = String.new
    value += "#{@REASON_DESPATCH}" if @REASON_DESPATCH
    value += " on #{@DISPOSAL_DATE}" if @DISPOSAL_DATE
    value += " by #{@DESPATCHER}" if @DESPATCHER
    value += ".\nApproved by #{@APPROVED_BY}" if @APPROVED_BY
    value += " on #{@APPROVED_DATE}" if @APPROVED_DATE
    value += ".\nReceived by #{@DES_REC_BY}" if @DES_REC_BY
    value += ".\n#{@DEACCESSION_NOTE}\n" if @DEACCESSION_NOTE
    value += ".\n#{@DEACC_DOC_GRP}\n" if @DEACC_DOC_GRP
    value + "\n"
  end
end
