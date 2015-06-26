class Accession
  include SAXMachine

  @@maps = {
    creators: %i[_creators1 _creators2],
    locationInformation: %i[_locationInformation1 _locationInformation2],
    processingNotes: %i[_processingNotes1 _processingNotes2 _processingNotes3 _processingNotes4 _processingNotes5 _processingNotes6 _processingNotes7]
  }

  # overload class method
  def self.column_names
    super - @@maps.values.flatten + @@maps.keys
  end
  
  # Used to generate an accessions CSV file
  element :EXTENT,            as: :receivedExtentUnits
  element :ACCNO,             as: :accessionNumber
  element :ACC_TITLE,         as: :title
  element :RECDATE,           as: :acquisitionDate
  element :ACQUISITION_TYPE,  as: :acquisitionType
  element :R_STATUS,          as: :processingStatus
  element :ACC_SCOPE,         as: :scopeAndContent

  # NB: this will take the value from all sub-elements ?
  element :EX_ACC_GROUP,  as: :PLEASE_FIX # FIXME: sub-elements: EX_ACC_DATE -> acquisitionDate | EX_ACC_NOTES -> processingNotes

  # NB: this will take the value from all sub-elements ?
  element :VALUATION_GROUP, as: :appraisal

  # NB: this will take the value from all sub-elements, eg. ORGANIZATION | INDIVIDUAL
  element :DONOR_GROUP,  as: :_creators1
  element :ACC_CREATOR,  as: :_creators2

  def creators(concat = '|')
    @@maps[:creators].map {|s| send(s)}.compact.join(concat)
  end

  # NB: this will take the value from all sub-elements, eg. LOCATION_DETAILS | ?
  element :LOCATION_GROUP, as: :_locationInformation1
  element :BUS_UNIT_OWNER, as: :_locationInformation2

  def locationInformation(concat = "\n")
    @@maps[:locationInformation].map {|s| send(s)}.compact.join(concat)
  end
  # NB: this will take the value from all sub-elements ?
  element :DESPATCH_GRP,      as: :_processingNotes1 # FIXME: handle merging
  element :EXTENT_KEPT,       as: :_processingNotes2
  element :COMMENTS_ACC,      as: :_processingNotes3
  element :PROC_STATUS,       as: :_processingNotes4
  element :ARRANGEMENT_NOTES, as: :_processingNotes5
  element :PROCESSING_NOTES,  as: :_processingNotes6
  element :ARC_NOTES,         as: :_processingNotes7

  def processingNotes(concat = "\n")
    @@maps[:processingNotes].map {|s| send(s)}.compact.join(concat)
  end
end