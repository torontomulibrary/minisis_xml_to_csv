class AccessionGroup
  include SAXMachine

  element :D_ACCNO
  element :PROCESSED

  def to_s
    return self.class.column_names.map { |col| send(col) }.compact.join("|")
  end
end

class Availability
  include SAXMachine

  element :OTHER_FORMATS
  element :CALL_NO

  def to_s
    return self.class.column_names.map { |col| send(col) }.compact.join("|")
  end
end

class FindaidGroup
  include SAXMachine

  element :FINDAID
  element :FINDAIDLINK
  element :FINDAID_URL

  def to_s
    return self.class.column_names.map { |col| send(col) }.compact.join("|")
  end
end

class ImageGroup
  include SAXMachine

  element :IMAGEFILE
  element :IMAGE_PRESENT
  element :IMAGE_COLOUR
  element :IMG_TECH_SPEC
  element :IMAGE_SIZE
  element :CAPTION
  element :IMAGE_EXTENT

  def to_s
    return self.class.column_names.map { |col| send(col) }.compact.join("|")
  end
end

class LowerLevel
  include SAXMachine

  element :LOWER_CODE
  element :LOWER_TITLE
  element :LOWER_TYPE

  def to_s
    return self.class.column_names.map { |col| send(col) }.compact.join("|")
  end
end

class OfficeOfOrigin
  include SAXMachine

  element :OFFICE_AB

  def to_s
    return self.class.column_names.map { |col| send(col) }.compact.join("|")
  end
end

class OriginationGroup
  include SAXMachine

  element :ORIGINATOR
  element :EAD_LABEL
  element :EAD_ROLE

  def to_s
    return self.class.column_names.map { |col| send(col) }.compact.join("|")
  end
end

class Description
  include SAXMachine

  # Define the columns we want in the CSV file
  @@maps = {
    accessConditions: %i[RESTRICTIONS],
    accessionNumber: %i[D_ACCNO],
    accruals: %i[ACCRUALS_NOTES],
    acquisition: %i[IMM_SOURCE_ACQ],
    alternateTitle: %i[PARALLEL_TITLE],
    alternativeIdentifiers: %i[STANDARD_NUMBER ISBN OTHER_CODES AV_NUMBER],
    archivalHistory: %i[CUSTODIAL_HIST],
    archivistNote: %i[BOX_NO COMMENTS_DESC],
    arrangement: %i[ARRANGEMENT],
    creatorDates: %i[DATE_CR_INC DATE_CR_PRED],
    creators: %i[ORIGINATION_GRP],
    extentAndMedium: %i[PHYSICAL_DESC],
    findingAids: %i[FINDAID],
    identifier: %i[REFD],
    language: %i[LANGUAGE LANGUAGE_MATU],
    languageNote: %i[LANGUAGE_NOTES],
    legacyId: %i[REFD],
    levelOfDescription: %i[LEVEL_DESC],
    locationOfCopies: %i[OTHER_FORMATS],
    locationOfOriginals: %i[LOC_OF_ORIGINAL],
    nameAccessPoints: %i[INDEXPROV ARCHITECT PUBLISHER OTHERS_RESP],
    parentId: %i[REFD_HIGHER],
    physicalCharacteristics: %i[PHYSICAL_COND CONDITION_NOTES],
    placeAccessPoints: %i[LOC_GEOG],
    publicationStatus: %i[WEBD],
    radEdition: %i[EDITION],
    radGeneralMaterialDesignation: %i[MEDIUM SMD FORM],
    radNoteAccompanyingMaterial: %i[ACCOMPANYING_MAT],
    radNoteConservation: %i[CONSERVATION],
    radNoteGeneral: %i[NOTES REFERENCE_REF CREDITS MODE_OR_PROCESS TECHNICAL_SPEC SOUND_CHAR],
    radNoteOnPublishersSeries: %i[PUBLISHER_SERIES],
    radNotePhysicalDescription: %i[PHYS_DESC_NOTES],
    radNoteRights: %i[COPYRIGHT_NOTE],
    radNoteSignatures: %i[SIGNATURES],
    radPublishersSeriesNote: %i[PUBLISHER_SERIES],
    radTitleAttributionsAndConjectures: %i[TITLE_NOTES ATTRIBUTIONS],
    radTitleStatementOfResponsibility: %i[STATEMENT_RESP],
    relatedUnitsOfDescription: %i[RELATED_MAT ASSOCIATED_MAT],
    reproductionConditions: %i[TERMS_GOV_USE],
    scopeAndContent: %i[SCOPE],
    subjectAccessPoints: %i[SUBJECT INDEXSUB],
    title: %i[TITLE]
  }

  # generate a method for each mapping so we can call it with saxrecord.mapname
  @@maps.each do |map,value|
    define_method(map) { value.map { |s| send(s) }.compact.join('|') }
  end

  # overload class method
  def self.column_names
    # super - @@maps.values.flatten + @@maps.keys
    @@maps.keys
  end

  # Define the elements that we want to pull out of the XML file
  # NB: each element/elements we add will be also added to column_names
  element :ABSTRACT
  elements :ACCESSION_GRP, class: AccessionGroup
  element :ACCOMPANYING_MAT
  element :ACCRUALS_NOTES
  elements :ARCHITECT
  element :ARCHIVIST_DESC
  elements :ARRANGEMENT
  elements :ASSOCIATED_MAT
  element :ATTRIBUTIONS
  element :AV_NUMBER
  elements :AVAILABILITY, class: Availability
  element :AVFILE
  element :BARCODE
  elements :BIO_SKETCH
  elements :BOX_NO
  element :CARTO_ADDRESS
  element :CARTO_CITY
  element :CARTO_PROV
  element :COLOUR
  elements :COMMENTS_DESC
  elements :CONDITION_NOTES
  elements :CONSERVATION
  element :COPYRGHT_NOTE
  elements :CREATOR
  elements :CREDITS
  elements :CUSTODIAL_HIST
  element :DATE_ACCUM
  element :DATE_CR_INC
  element :DATE_CR_PRED
  element :DATE_NOTES
  element :DATE_SEARCH
  element :DESC_SOURCE
  element :DESC_TYPE
  element :EDITION
  element :ENTRY_DATE
  elements :FINDAID_GROUP, class: FindaidGroup
  elements :FORM
  elements :IMAGE_GROUP, class: ImageGroup
  elements :IMM_SOURCE_ACQ
  elements :INDEXGEO
  elements :INDEXPROV
  elements :INDEXSUB
  element :INPUT_BY
  elements :ISBN
  elements :ITEM_EXTENT
  elements :LANGUAGE
  element :LANGUAGE_DESC
  elements :LANGUAGE_MAT
  element :LANGUAGE_NOTES
  element :LEVEL_DESC
  element :LOC_GEOG
  element :LOC_OF_ORIGINAL
  elements :LOCATION
  elements :LOWER_LEVEL, class: LowerLevel
  element :M3_ACCNO
  elements :MEDIUM
  element :MODE_OR_PROCESS
  elements :NOTES
  elements :OFFICE_OF_ORIGIN, class: OfficeOfOrigin
  elements :ORIGINATION_GRP, class: OriginationGroup
  elements :OTHER_CODES
  elements :OTHER_CONTEXT
  elements :OTHERS_RESP
  elements :PARALLEL_TITLE
  element :PARENT_ACCNO
  element :PHYS_DESC_NOTES
  elements :PHYSICAL_COND
  elements :PHYSICAL_DESC
  element :PLACE_OF_PUB
  element :PLAYING_SPEED
  element :PUBLISHER
  element :PUBLISHER_SERIES
  element :REFD
  element :REFD_HIGHER
  element :REFD_LOWEREXIST
  elements :REFERENCE_REF
  elements :RELATED_MAT
  elements :RESTRICTIONS
  element :RYE_GEN_ACCESS
  elements :SCOPE
  element :SIGNATURES
  element :SISN
  element :SIZE
  elements :SMD
  element :SOUND_CHAR
  elements :SPECIFIC_LOC
  element :STANDARD_NUMBER
  element :STATEMENT_RESP
  element :STATUSD
  elements :SUBJECT
  element :TECHNICAL_SPEC
  elements :TERMS_GOV_USE
  element :TEXT_IMAGEFILE
  element :TIME
  element :TITLE
  elements :TITLE_NOTES
  element :TOP_LEVEL_FLAG
  element :TRANSLATE_EXIST
  element :WEBD


  # methods for special cases (i.e.: nested elements)
  def D_ACCNO(concat = '|')
    parent = send(:ACCESSION_GRP)
    parent.map { |r| r.D_ACCNO }.compact.join(concat) unless parent.nil?
  end 

  def FINDAID(concat = '|')
    parent = send(:FINDAID_GROUP)
    parent.map { |r| r.FINDAID }.compact.join(concat) unless parent.nil?
  end 
  
  def OTHER_FORMATS(concat = '|')
    parent = send(:AVAILABILITY)
    parent.map { |r| r.OTHER_FORMATS }.compact.join(concat) unless parent.nil?
  end 

end
