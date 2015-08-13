Dir[File.dirname(__FILE__) + '/authority/*.rb'].each { |file| require file }

# Authority
class Authority
  include SAXMachine

  # Define the columns we want in the CSV file
  @maps = {
    alternateForm:          %i(VARIANT_NAME PREDECESSOR SUCCESSOR
                               PARALLEL_NAME),
    authorizedFormOfName:   %i(HEADING),
    datesOfExistence:       %i(CONTROLLING_GRP),
    history:                %i(ADMIN_HISTORY),
    status:                 %i(STATUSA),
    typeOfEntity:           %i(AUTHORITY_TYPE)
  }

  # generate a method for each mapping so we can call it with saxrecord.mapname
  @maps.each do |map, value|
    define_method(map) { value.map { |s| send(s) }.compact.join("\n") }
  end

  # overload class method
  def self.column_names
    @maps.keys
  end

  # Define the elements that we want to pull out of the XML file
  # NB: each element/elements we add will be also added to column_names
  elements :ADMIN_HISTORY
  element :ARCHIVIST_AUTH
  element :AUTH_ENTRY_DATE
  element :AUTH_INPUT_BY
  element :AUTHORITY_CATGRY
  elements :AUTHORITY_TYPE
  element :BRIEF_BIO
  elements :COMMENTS_AUTH
  elements :CONTROLLING_GRP, class: ControllingGroup
  element :HEADING
  element :HEADING2
  elements :PARALLEL_NAME
  elements :PREDECESSOR
  element :SISN
  elements :SOURCE
  element :STATUSA
  elements :SUCCESSOR
  elements :VARIANT_NAME
  element :WEBA
end
