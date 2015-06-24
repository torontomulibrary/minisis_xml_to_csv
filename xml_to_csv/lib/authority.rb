class Authority
  include SAXMachine

  # Used to generate an authorities CSV file
  element :AUTHORITY_TYPE
  element :HEADING
  element :ADMIN_HISTORY
  element :STATUSA
  element :CONTROLLING_GRP # FIXME: sub-element(s)

  # Used to generate an alternate authorities CSV file
  element :VARIANT_NAME
  element :PREDECESSOR
  element :SUCCESSOR
  element :PARALLEL_NAME
end