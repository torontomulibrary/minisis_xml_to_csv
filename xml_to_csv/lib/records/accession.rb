class Accession
  include SAXMachine

  # Used to generate an accessions CSV file
  element :EXTENT,            as: :receivedExtentUnits
  element :ACCNO,             as: :accessionNumber
  element :ACC_TITLE,         as: :title
  element :RECDATE,           as: :acquisitionDate
  element :ACQUISITION_TYPE,  as: :acquisitionType
  element :R_STATUS,          as: :processingStatus
  element :ACC_SCOPE,         as: :scopeAndContent

  # NB: this will take the value from all sub-elements, eg. ORGANIZATION | INDIVIDUAL
  element :DONOR_GROUP,  as: :creators # FIXME: pipe-delimited
  element :ACC_CREATOR,  as: :creators # FIXME: handle merging

  element :EX_ACC_GROUP,  as: :PLEASE_FIX # FIXME: sub-elements: EX_ACC_DATE | EX_ACC_NOTES

  # NB: this will take the value from all sub-elements, eg. LOCATION_DETAILS | ?
  element :LOCATION_GROUP, as: :locationInformation # FIXME
  element :BUS_UNIT_OWNER, as: :locationInformation # FIXME: handle merging

  element :EXTENT_KEPT,       as: :processingNotes # FIXME: handle merging
  element :COMMENTS_ACC,      as: :processingNotes # FIXME: handle merging
  element :PROC_STATUS,       as: :processingNotes # FIXME: handle merging
  element :ARRANGEMENT_NOTES, as: :processingNotes # FIXME: handle merging
  element :PROCESSING_NOTES,  as: :processingNotes # FIXME: handle merging
  element :ARC_NOTES,         as: :processingNotes # FIXME: handle merging

  # NB: this will take the value from all sub-elements ?
  element :VALUATION_GROUP, as: :appraisal

  # NB: this will take the value from all sub-elements ?
  element :DESPATCH_GRP, as: :processingNotes # FIXME: handle merging
end