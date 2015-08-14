Dir[File.dirname(__FILE__) + '/description/*.rb'].each { |file| require file }

# Description
class Description
  include SAXMachine

  # Define the columns we want in the CSV file
  @maps = {
    legacyId:           %i(REFD),
    parentId:           %i(REFD_HIGHER),
    accessionNumber:    %i(D_ACCNO),
    title:              %i(TITLE),
    radGeneralMaterialDesignation:  %i(MEDIUM SMD FORM),
    alternateTitle:         %i(PARALLEL_TITLE),
    radTitleStatementOfResponsibility:  %i(STATEMENT_RESP),
    radTitleAttributionsAndConjectures: %i(TITLE_NOTES ATTRIBUTIONS),
    levelOfDescription:     %i(LEVEL_DESC),
    identifier:             %i(REFD),
    alternativeIdentifiers: %i(STANDARD_NUMBER ISBN OTHER_CODES AV_NUMBER),
    radEdition:               %i(EDITION),
    creators:               %i(ORIGINATOR),
    creatorDates:           %i(DATE_CR_INC DATE_CR_PRED),
    extentAndMedium:        %i(PHYSICAL_DESC),
    radPublishersSeriesNote:            %i(PUBLISHER_SERIES),
    radNoteOnPublishersSeries:          %i(PUBLISHER_SERIES),
    archivalHistory:        %i(CUSTODIAL_HIST),
    scopeAndContent:                    %i(SCOPE),
    physicalCharacteristics:  %i(PHYSICAL_COND CONDITION_NOTES),
    acquisition:            %i(IMM_SOURCE_ACQ),
    arrangement:            %i(ARRANGEMENT),
    language:               %i(LANGUAGE LANGUAGE_MAT),
    languageNote:           %i(LANGUAGE_NOTES),
    locationOfOriginals:    %i(LOC_OF_ORIGINAL),
    locationOfCopies:       %i(AVAILABILITY),
    accessConditions:   %i(RESTRICTIONS),
    reproductionConditions:             %i(TERMS_GOV_USE),
    findingAids:            %i(FINDAID_GROUP),
    relatedUnitsOfDescription:          %i(RELATED_MAT ASSOCIATED_MAT),
    accruals:           %i(ACCRUALS_NOTES),
    radNoteAccompanyingMaterial:    %i(ACCOMPANYING_MAT),
    radNoteConservation:            %i(CONSERVATION),
    radNotePhysicalDescription:         %i(PHYS_DESC_NOTES),
    radNoteRights:                      %i(COPYRGHT_NOTE),
    radNoteSignaturesInscriptions:                  %i(SIGNATURES),
    radNoteGeneral:       %i(NOTES REFERENCE_REF CREDITS MODE_OR_PROCESS
                             TECHNICAL_SPEC SOUND_CHAR),
    subjectAccessPoints:  %i(SUBJECT INDEXSUB),
    placeAccessPoints:    %i(LOC_GEOG),
    nameAccessPoints:     %i(INDEXPROV ARCHITECT PUBLISHER OTHERS_RESP),
    publicationStatus:    %i(WEBD),

    # what is this one?
    archivistNote:          %i(BOX_NO COMMENTS_DESC)
  }

  # fields which can have multiple pipe-separated values
  # from: https://github.com/ryersonlibrary/atom/blob/RULA/2.2.x/lib/task/import/csvImportTask.class.php#L387-L417
  @multi_value = %i(accessionNumber creators creatorHistories creationDates creationDateNotes
                    creationDatesStart creationDatesEnd creatorDates creatorDatesStart
                    creatorDatesEnd creatorDateNotes nameAccessPoints nameAccessPointHistories
                    placeAccessPoints placeAccessPointHistories subjectAccessPoints
                    subjectAccessPointScopes eventActors eventTypes eventPlaces eventDates
                    eventStartDates eventEndDates eventDescriptions alternativeIdentifiers
                    alternativeIdentifierLabels)

  def self.concat(element = nil)
    (@multi_value.include?(element) ? '|' : "\n")
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
  element :ABSTRACT
  elements :ACCESSION_GRP,    class: AccessionGroup
  element :ACCOMPANYING_MAT
  element :ACCRUALS_NOTES
  elements :ARCHITECT
  element :ARCHIVIST_DESC
  elements :ARRANGEMENT
  elements :ASSOCIATED_MAT
  element :ATTRIBUTIONS
  element :AV_NUMBER
  elements :AVAILABILITY,     class: Availability
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
  elements :FINDAID_GROUP,    class: FindaidGroup
  elements :FORM
  elements :IMAGE_GROUP,      class: ImageGroup
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
  elements :LOWER_LEVEL,      class: LowerLevel
  element :M3_ACCNO
  elements :MEDIUM
  element :MODE_OR_PROCESS
  elements :NOTES
  elements :OFFICE_OF_ORIGIN, class: OfficeOfOrigin
  elements :ORIGINATION_GRP,  class: OriginationGroup
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
  def REFD_HIGHER
    @REFD_HIGHER.to_s.gsub('\n', '').strip
  end

  def ORIGINATOR
    origin = send(:ORIGINATION_GRP).map(&:ORIGINATOR)
    office = send(:OFFICE_OF_ORIGIN).map(&:OFFICE_AB)
    (origin + office).flatten.compact.uniq.join(concat(:creators))
  end

  def D_ACCNO
    send(:ACCESSION_GRP).map(&:D_ACCNO).flatten.compact.uniq.join(concat(:accessionNumber))
  end
end
