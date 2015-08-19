Dir[File.dirname(__FILE__) + '/accession/*.rb'].each { |file| require file }

# Accession
class Accession
  include SAXMachine

  # Define the columns we want in the CSV file
  @maps = {
    accessionNumber:      %i(ACCNO),
    acquisitionDate:      %i(RECDATE EX_ACC_DATE),
    acquisitionType:      %i(ACQUISITION_TYPE),
    appraisal:            %i(VALUATION_GROUP),
    creators:             %i(ACC_CREATOR),
    donorName:            %i(DONOR_GROUP),
    locationInformation:  %i(BUS_UNIT_OWNER LOCATION_GROUP),
    processingNotes:      %i(EXTENT_KEPT COMMENTS_ACC ARRANGEMNT_NOTES
                             PROCESSING_NOTES ARC_NOTES DESPATCH_GRP
                             EX_ACC_NOTES),
    processingStatus:     %i(R_STATUS PROC_STATUS),
    receivedExtentUnits:  %i(EXTENT),
    scopeAndContent:      %i(ACC_SCOPE),
    title:                %i(ACC_TITLE)
  }

  # fields which can have multiple pipe-separated values
  # from: https://github.com/ryersonlibrary/atom/blob/RULA/2.2.x/lib/task/import/csvAccessionImportTask.class.php#L120-L136
  @concatenators = {
    creators: '|',
    creatorHistories: '|',
    creationDates: '|',
    creationDatesStart: '|',
    creationDatesEnd: '|',
    creationDatesType: '|',
    creatorDates: '|',
    creatorDatesStart: '|',
    creatorDatesEnd: '|',
    eventActors: '|',
    eventTypes: '|',
    eventPlaces: '|',
    eventDates: '|',
    eventStartDates: '|',
    eventEndDates: '|',
    eventDescriptions: '|',
    processingStatus: ' '
  }

  def self.concat(element = nil)
    (@concatenators.include?(element) ? @concatenators[element] : "\n")
  end

  def concat(element = nil)
    self.class.concat(element)
  end

  # overload class method
  def self.column_names
    @maps.keys
  end

  # generate a method for each mapping so we can call it with saxrecord.mapname
  @maps.each do |map, value|
    define_method(map) { value.map { |s| send(s) }.flatten.compact.uniq.join(concat(map)) }
  end

  # Define the elements that we want to pull out of the XML file
  # NB: each element/elements we add will be also added to column_names
  elements :ACC_CREATOR
  element :ACC_SCOPE
  element :ACC_TITLE
  element :ACCNO
  element :ACQUISITION_TYPE
  elements :ARC_NOTES
  elements :ARRANGEMNT_NOTES
  element :BUS_UNIT_OWNER
  elements :COMMENTS_ACC
  elements :DESPATCH_GRP,    class: DespatchGroup
  elements :DONOR_GROUP,     class: DonorGroup
  elements :EX_ACC_GROUP,    class: ExAccGroup
  elements :EXTENT
  elements :EXTENT_KEPT
  elements :LOCATION_GROUP,  class: LocationGroup
  element :PROC_STATUS
  elements :PROCESSING_NOTES
  element :R_STATUS
  element :RECDATE
  elements :VALUATION_GROUP, class: ValuationGroup

  # methods for special cases (i.e.: nested elements)
  def EX_ACC_DATE
    send(:EX_ACC_GROUP).map(&:EX_ACC_DATE).flatten.compact.uniq.join(concat(:acquisitionDate))
  end

  def EX_ACC_NOTES
    send(:EX_ACC_GROUP).map(&:EX_ACC_NOTES).flatten.compact.uniq.join(concat(:processingNotes))
  end
end
