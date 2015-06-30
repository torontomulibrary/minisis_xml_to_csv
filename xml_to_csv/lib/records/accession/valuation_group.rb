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
    return self.class.column_names.map { |col| send(col) }.compact.join("|")
  end
end