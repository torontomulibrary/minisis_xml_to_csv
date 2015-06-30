class LocationGroup
  include SAXMachine

  element :LOCATION_DETAILS
  element :BOX_ITEM_NUMBER
  element :ITEM_DESC_REF
  element :BOXLIST_LINK
  element :ACC_LOC_CODE
  element :LOCATION_EXTENT
  element :LOCATION_UNIT
  element :BARCODE_DATE

  def to_s
    return self.class.column_names.map { |col| send(col) }.compact.join("|")
  end
end