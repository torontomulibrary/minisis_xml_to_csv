class Authority
  include SAXMachine

  # Used to generate an authorities CSV file
  element :AUTHORITY_TYPE,  as: :typeOfEntity
  element :HEADING,         as: :authorizedFormOfName
  element :ADMIN_HISTORY,   as: :history
  element :STATUSA,         as: :status

  # NB: this will take the value from all sub-elements, eg. DATE_CONTROLLED
  element :CONTROLLING_GRP, as: :datesOfExistence

  # Used to generate an alternate authorities CSV file
  element :VARIANT_NAME,    as: :alternateForm1
  element :PREDECESSOR,     as: :alternateForm2
  element :SUCCESSOR,       as: :alternateForm3
  element :PARALLEL_NAME,   as: :alternateForm4
end