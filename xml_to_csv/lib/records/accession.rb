Dir[File.dirname(__FILE__) + '/accession/*.rb'].each {|file| require file }

class Accession
  include SAXMachine

  # Define the columns we want in the CSV file
  @@maps = {
    accessionNumber: %i[ACCNO],
    acquisitionDate: %i[RECDATE EX_ACC_DATE], 
    acquisitionType: %i[ACQUISITION_TYPE],
    appraisal: %i[VALUATION_GROUP],
    creators: %i[ACC_CREATOR DONOR_GROUP], 
    locationInformation: %i[BUS_UNIT_OWNER LOCATION_DETAILS],
    processingNotes: %i[EXTENT_KEPT COMMENTS_ACC ARRANGEMNT_NOTES 
                     PROCESSING_NOTES ARC_NOTES DESPATCH_GRP EX_ACC_NOTES],
    processingStatus: %i[R_STATUS PROC_STATUS],
    receivedExtentUnits: %i[EXTENT],
    scopeAndContent: %i[ACC_SCOPE],
    title: %i[ACC_TITLE],
  }

  # generate a method for each mapping so we can call it with saxrecord.mapname
  @@maps.each do |map,value|
    define_method(map) { value.map { |s| send(s) }.compact.join('|') }
  end

  # overload class method
  def self.column_names
    @@maps.keys
  end

  # Define the elements that we want to pull out of the XML file
  # NB: each element/elements we add will be also added to column_names
  elements  :ACC_CREATOR
  element   :ACC_SCOPE
  element   :ACC_TITLE
  element   :ACCNO
  element   :ACQUISITION_TYPE
  elements  :ARC_NOTES
  elements  :ARRANGEMNT_NOTES
  element   :BUS_UNIT_OWNER
  elements  :COMMENTS_ACC
  elements  :DESPATCH_GRP, class: DespatchGroup
  elements  :DONOR_GROUP, class: DonorGroup
  elements  :EX_ACC_GROUP, class: ExAccGroup
  elements  :EXTENT
  elements  :EXTENT_KEPT
  elements  :LOCATION_GROUP, class: LocationGroup
  element   :PROC_STATUS
  elements  :PROCESSING_NOTES
  element   :R_STATUS
  element   :RECDATE
  elements  :VALUATION_GROUP, class: ValuationGroup

  # methods for special cases (i.e.: nested elements)
  def EX_ACC_DATE(concat = '|')
    parent = send(:EX_ACC_GROUP)
    parent.map { |r| r.EX_ACC_DATE }.compact.join(concat) unless parent.nil?
  end  

  def EX_ACC_NOTES(concat = '|')
    parent = send(:EX_ACC_GROUP)
    parent.map { |r| r.EX_ACC_NOTES }.compact.join(concat) unless parent.nil?
  end

  def LOCATION_DETAILS(concat = '|')
    parent = send(:LOCATION_GROUP)
    parent.map { |r| r.LOCATION_DETAILS }.compact.join(concat) unless parent.nil?
  end
end