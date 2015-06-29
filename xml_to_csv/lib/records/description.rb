class AccessionGroup
  include SAXMachine

  element :D_ACCNO, as: :accessionNumber
end

class Availability
  include SAXMachine

  element :OTHER_FORMATS, as: :locationOfCopies
end

class FindingAids
  include SAXMachine
  element :FINDAID, as: :findingAids
end

class OriginationGroup
  include SAXMachine
  element :ORIGINATOR, as: :originator
end

class Description
  include SAXMachine

  @@maps = {
    radGeneralMaterialDesignation: %i[MEDIUM SMD FORM],
    subjectAccessPoints: %i[SUBJECT INDEXSUB],
    creatorDates: %i[DATE_CR_INC DATE_CR_PRED],
    archivistNote: %i[BOX_NO COMMENTS_DESC],
    nameAccessPoints: %i[PUBLISHER INDEXPROV ARCHITECT OTHERS_RESP],
    radNoteGeneral: %i[NOTES REFERENCE_REF CREDITS 
                    MODE_OR_PROCESS TECHNICAL_SPEC SOUND_CHAR],
    physicalCharacteristics: %i[PHYSICAL_COND CONDITION_NOTES],
    language: %i[LANGUAGE LANGUAGE_MAT],
    radTitleAttributionsAndConjectures: %i[TITLE_NOTES ATTRIBUTIONS],
    relatedUnitsOfDescription: %i[RELATED_MAT ASSOCIATED_MAT],
    alternativeIdentifiers: %i[STANDARD_NUMBER ISBN OTHER_CODES AV_NUMBER],
    accessionNumber: %i[ACCESSION_GRP],
    locationOfCopies: %i[AVAILABILITY],
    findingAids: %i[FINDAID_GROUP],
    creators: %i[ORIGINATION_GRP],
  }
  
  # overload class method
  def self.column_names
    super - @@maps.values.flatten + @@maps.keys
  end

  element :ACCESSION_GRP,     class: AccessionGroup
  def accessionNumber
    send(:ACCESSION_GRP).accessionNumber unless send(:ACCESSION_GRP).nil?
  end

  element :REFD,              as: :legacyId
  element :REFD,              as: :identifier
  element :TITLE,             as: :title
  element :LEVEL_DESC,        as: :levelOfDescription
  element :WEBD,              as: :publicationStatus
  element :REFD_HIGHER,       as: :parentId
  element :PHYSICAL_DESC,     as: :extentAndMedium
  element :RESTRICTIONS,      as: :accessConditions
  element :SCOPE,             as: :scopeAndContent

  elements :ORIGINATION_GRP,  class: OriginationGroup
  def creators(concat = '|')
    send(:ORIGINATION_GRP).map { |s| s.originator }.compact.join(concat) unless send(:ORIGINATION_GRP).nil?
  end

  element :COPYRIGHT_NOTE,    as: :radNoteRights

  elements :AVAILABILITY,      class: Availability
  def locationOfCopies(concat = '|')
    send(:AVAILABILITY).map { |s| s.locationOfCopies }.compact.join(concat) unless send(:AVAILABILITY).nil?
  end

  element :LOC_GEOG,          as: :placeAccessPoints
  element :SIGNATURES,        as: :radNoteSignatures
  element :TERMS_GOV_USE,     as: :reproductionConditions
  element :CUSTODIAL_HIST,    as: :archivalHistory
  element :PARALLEL_TITLE,    as: :alternateTitle
  element :STATEMENT_RESP,    as: :radTitleStatementOfResponsibility
  element :IMM_SOURCE_ACQ,    as: :acquisition
  element :PUBLISHER_SERIES,  as: :radPublishersSeriesNote
  element :PUBLISHER_SERIES,  as: :radNoteOnPublishersSeries
  element :ACCOMPANYING_MAT,  as: :radNoteAccompanyingMaterial
  element :ARRANGEMENT,       as: :arrangement
  element :PHYS_DESC_NOTES,   as: :radNotePhysicalDescription
  element :ACCRUALS_NOTES,    as: :accruals
  element :EDITION,           as: :radEdition
  element :LANGUAGE_NOTES,    as: :languageNote

  elements :FINDAID_GROUP,    class: FindingAids
  def findingAids(concat = '|')
    send(:FINDAID_GROUP).map { |s| s.findingAids }.compact.join(concat) unless send(:FINDAID_GROUP).nil?
  end

  element :LOC_OF_ORIGINAL,   as: :locationOfOriginals
  element :CONSERVATION,      as: :radNoteConservation

  # merge <DATE_CR_INC>, <DATE_CR_PRED> to column creatorDates
  element :DATE_CR_INC
  element :DATE_CR_PRED
  def creatorDates(concat = '|')
    @@maps[:creatorDates].map {|s| send(s)}.compact.join(concat)
  end

  # merge <NOTES>, <REFERENCE_REF>, <CREDITS>, <MODE_OR_PROCESS>, 
  # <TECHNICAL_SPEC>, <SOUND_CHAR>  to column radNoteGeneral
  element :MODE_OR_PROCESS
  element :TECHNICAL_SPEC
  element :SOUND_CHAR
  elements :NOTES
  elements :REFERENCE_REF
  elements :CREDITS
  def radNoteGeneral(concat = '|')
    @@maps[:radNoteGeneral].map {|s| send(s)}.compact.join(concat)
  end

  # merge <PHYSICAL_COND>, <CONDITION_NOTES> to column physicalCharacteristics
  elements :PHYSICAL_COND
  elements :CONDITION_NOTES
  def physicalCharacteristics(concat = '|')
    @@maps[:physicalCharacteristics].map {|s| send(s)}.compact.join(concat)
  end

  # merge <LANGUAGE_MAT>, <LANGUAGE> to column language
  elements :LANGUAGE_MAT
  elements :LANGUAGE
  def language(concat = '|')
    @@maps[:language].map {|s| send(s)}.compact.join(concat)
  end

  # merge <TITLE_NOTES>, <ATTRIBUTIONS> to column radTitleAttributionsAndConjectures
  element :ATTRIBUTIONS
  elements :TITLE_NOTES
  def radTitleAttributionsAndConjectures(concat = '|')
    @@maps[:radTitleAttributionsAndConjectures].map {|s| send(s)}.compact.join(concat)
  end

  # merge <RELATED_MAT>, <ASSOCIATED_MAT> to column relatedUnitsOfDescription
  elements :RELATED_MAT
  elements :ASSOCIATED_MAT
  def relatedUnitsOfDescription(concat = '|')
    @@maps[:relatedUnitsOfDescription].map {|s| send(s)}.compact.join(concat)
  end

  # merge <STANDARD_NUMBER>, <ISBN>, <OTHER_CODES>, <AV_NUMBER> 
  # to column alternativeIdentifiers
  element :STANDARD_NUMBER
  element :AV_NUMBER
  elements :ISBN
  elements :OTHER_CODES
  def alternativeIdentifiers(concat = '|')
    @@maps[:alternativeIdentifiers].map {|s| send(s)}.compact.join(concat)
  end

  # merge <SUBJECT>, <INDEXSUB> to column subjectAccessPoints
  elements :SUBJECT
  elements :INDEXSUB
  def subjectAccessPoints(concat = '|')
    @@maps[:subjectAccessPoints].map {|s| send(s)}.compact.join(concat)
  end

  # merge <PUBLISHER>, <INDEXPROV>, <ARCHITECT>, <OTHERS_RESP> 
  # to column nameAccessPoints
  element :PUBLISHER
  elements :INDEXPROV
  elements :ARCHITECT
  elements :OTHERS_RESP
  def nameAccessPoints(concat = '|')
    @@maps[:nameAccessPoints].map {|s| send(s)}.compact.join(concat)
  end

  # merge <MEDIUM>, <SMD>, <FORM> to column radGeneralMaterialDesignation
  elements :MEDIUM
  elements :SMD
  elements :FORM
  def radGeneralMaterialDesignation(concat = '|')
    @@maps[:radGeneralMaterialDesignation].map {|s| send(s)}.compact.join(concat)
  end

  # merge <BOX_NO>, <COMMENTS_DESC> to column archivistNote
  elements :BOX_NO
  elements :COMMENTS_DESC
  def archivistNote(concat = '|')
    @@maps[:archivistNote].map {|s| send(s)}.compact.join(concat)
  end
end