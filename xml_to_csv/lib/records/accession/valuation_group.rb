# ValuationGroup
class ValuationGroup
  include SAXMachine

  element :PURCHASE_PRICE
  element :PURCHASE_CUR
  element :VALUATION_DATE
  element :VAL_DATE
  element :EST_VAL_CUR
  element :VAL_AMOUNT
  element :VALUATION
  element :VALUE_CUR
  element :VALUATION_TYPE
  element :VALUER
  element :VALUATION2_TYPE
  element :VALUATION_NOTICE
  element :VAL_REN_DATE

  def to_s
    value = String.new
    value += "Purchased for #{@PURCHASE_PRICE} #{@PURCHASE_CUR}.\n" if @PURCHASE_PRICE
    value += "Valued at #{[@VAL_AMOUNT, @VALUATION].compact.uniq.join(' / ')} #{[@EST_VAL_CUR, @VALUE_CUR].compact.uniq.first}" if @VAL_AMOUNT or @VALUATION
    value += " (#{[@VALUATION_TYPE, @VALUATION2_TYPE].compact.uniq.join(' / ')})" if @VALUATION_TYPE or @VALUATION2_TYPE
    value += " on #{[@VAL_DATE, @VALUATION_DATE, @VAL_REN_DATE].compact.uniq.join(' / ')}" if @VAL_DATE or @VALUATION_DATE or @VAL_REN_DATE
    value += " by #{@VALUER}" if @VALUER
    value += ".\n#{@VALUATION_NOTICE}" if @VALUATION_NOTICE
    value + "\n"
  end
end
