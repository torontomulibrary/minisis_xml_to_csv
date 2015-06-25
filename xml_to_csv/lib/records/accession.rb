class Accession
  include SAXMachine

  # class methods
  def self.maps
    {
      creators: %i[_creators1 _creators2],
      locationInformation: %i[_locationInformation1 _locationInformation2],
      processingNotes: %i[_processingNotes1 _processingNotes1 _processingNotes1 _processingNotes1 _processingNotes1 _processingNotes1]
    }
  end

  def self.column_names
    super - maps.values.flatten + maps.keys
  end
  
  # Used to generate an accessions CSV file
  element :EXTENT,            as: :receivedExtentUnits
  element :ACCNO,             as: :accessionNumber
  element :ACC_TITLE,         as: :title
  element :RECDATE,           as: :acquisitionDate
  element :ACQUISITION_TYPE,  as: :acquisitionType
  element :R_STATUS,          as: :processingStatus
  element :ACC_SCOPE,         as: :scopeAndContent

  # NB: this will take the value from all sub-elements, eg. ORGANIZATION | INDIVIDUAL
  element :DONOR_GROUP,  as: :_creators1
  element :ACC_CREATOR,  as: :_creators2

  def creators(concat = '|')
    self.class.maps[:creators].map {|s| send(s)}.compact.join(concat)
  end

  element :EX_ACC_GROUP,  as: :PLEASE_FIX # FIXME: sub-elements: EX_ACC_DATE | EX_ACC_NOTES

  # NB: this will take the value from all sub-elements ?
  element :VALUATION_GROUP, as: :appraisal

  # NB: this will take the value from all sub-elements ?
  element :DESPATCH_GRP, as: :processingNotes # FIXME: handle merging

  # NB: this will take the value from all sub-elements, eg. LOCATION_DETAILS | ?
  element :LOCATION_GROUP, as: :_locationInformation1
  element :BUS_UNIT_OWNER, as: :_locationInformation2

  def locationInformation(concat = "\n")
    self.class.maps[:locationInformation].map {|s| send(s)}.compact.join(concat)
  end

  element :EXTENT_KEPT,       as: :_processingNotes1
  element :COMMENTS_ACC,      as: :_processingNotes2
  element :PROC_STATUS,       as: :_processingNotes3
  element :ARRANGEMENT_NOTES, as: :_processingNotes4
  element :PROCESSING_NOTES,  as: :_processingNotes5
  element :ARC_NOTES,         as: :_processingNotes6

  def processingNotes(concat = "\n")
    self.class.maps[:processingNotes].map {|s| send(s)}.compact.join(concat)
  end
end