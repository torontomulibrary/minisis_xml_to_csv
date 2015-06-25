class Authority
  include SAXMachine

  # class methods
  def self.maps
    {
      alternateForm: %i[_alternateForm1 _alternateForm2 _alternateForm3 _alternateForm4]
    }
  end

  def self.column_names
    super - maps.values.flatten + maps.keys
  end

  # Used to generate an authorities CSV file
  element :AUTHORITY_TYPE,  as: :typeOfEntity
  element :HEADING,         as: :authorizedFormOfName
  element :ADMIN_HISTORY,   as: :history
  element :STATUSA,         as: :status

  # NB: this will take the value from all sub-elements, eg. DATE_CONTROLLED
  element :CONTROLLING_GRP, as: :datesOfExistence

  # Used to generate an alternate authorities CSV file
  element :VARIANT_NAME,    as: :_alternateForm1
  element :PREDECESSOR,     as: :_alternateForm2
  element :SUCCESSOR,       as: :_alternateForm3
  element :PARALLEL_NAME,   as: :_alternateForm4

  def alternateForm(concat = '|')
    self.class.maps[:alternateForm].map {|s| send(s)}.compact.join(concat)
  end
end