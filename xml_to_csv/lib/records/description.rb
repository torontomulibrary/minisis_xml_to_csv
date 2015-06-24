class Description
  include SAXMachine
  
  element :ACCESSION_GRP,     as: :accessionNumber # FIXME: use sub-element: D_ACCNO
  element :SUBJECT,           as: :subjectAccessPoints
  element :REFD,              as: :legacyId
  element :REFD,              as: :identifier
  element :TITLE,             as: :title
  element :LEVEL_DESC,        as: :levelOfDescription
  element :WEBD,              as: :publicationStatus
  element :REFD_HIGHER,       as: :parentId
  element :DATE_CR_INC,       as: :creatorDates
  element :PHYSICAL_DESC,     as: :extentAndMedium
  element :RESTRICTIONS,      as: :accessConditions
  element :MEDIUM,            as: :radGeneralMaterialDesignation
  element :SMD,               as: :radGeneralMaterialDesignation
  element :SCOPE,             as: :scopeAndContent

  # NB: this will take the value from all sub-elements, eg. ORGANIZATION | INDIVIDUAL
  element :ORIGINATION_GRP,   as: :creators # FIXME: pipe-delimited
  element :BOX_NO,            as: :archivistNote
  element :COMMENTS_DESC,     as: :archivistNote
  element :COPYRIGHT_NOTE,    as: :radNoteRights
  element :AVAILABILITY,      as: :locationOfCopies # FIXME: use sub-element: OTHER_FORMATS
  element :INDEXPROV,         as: :nameAccessPoints
  element :NOTES,             as: :radNoteGeneral
  element :PHYSICAL_COND,     as: :physicalCharacteristics
  element :LOC_GEOG,          as: :placeAccessPoints
  element :LANGUAGE_MAT,      as: :language
  element :SIGNATURES,        as: :radNoteSignatures
  element :TITLE_NOTES,       as: :radTitleAttributionsAndConjectures
  element :FORM,              as: :radGeneralMaterialDesignation
  element :TERMS_GOV_USE,     as: :reproductionConditions
  element :CUSTODIAL_HIST,    as: :archivalHistory
  element :ARCHITECT,         as: :nameAccessPoints
  element :PARALLEL_TITLE,    as: :alternateTitle
  element :RELATED_MAT,       as: :relatedUnitsOfDescription
  element :CONDITION_NOTES,   as: :physicalCharacteristics
  element :INDEXSUB,          as: :subjectAccessPoints
  element :STANDARD_NUMBER,   as: :alternativeIdentifiers
  element :PUBLISHER,         as: :nameAccessPoints
  element :OTHERS_RESP,       as: :nameAccessPoints
  element :DATE_CR_PRED,      as: :creatorDates
  element :STATEMENT_RESP,    as: :radTitleStatementOfResponsibility
  element :IMM_SOURCE_ACQ,    as: :acquisition
  element :REFERENCE_REF,     as: :radNoteGeneral
  element :CREDITS,           as: :radNoteGeneral
  element :MODE_OR_PROCESS,   as: :radNoteGeneral
  element :ISBN,              as: :alternativeIdentifiers
  element :PUBLISHER_SERIES,  as: :radPublishersSeriesNote
  element :PUBLISHER_SERIES,  as: :radNoteOnPublishersSeries
  element :ACCOMPANYING_MAT,  as: :radNoteAccompanyingMaterial
  element :ASSOCIATED_MAT,    as: :relatedUnitsOfDescription
  element :TECHNICAL_SPEC,    as: :radNoteGeneral
  element :ARRANGEMENT,       as: :arrangement
  element :PHYS_DESC_NOTES,   as: :radNotePhysicalDescription
  element :SOUND_CHAR,        as: :radNoteGeneral
  element :ACCRUALS_NOTES,    as: :accruals
  element :EDITION,           as: :radEdition
  element :LANGUAGE_NOTES,    as: :languageNote
  element :LANGUAGE,          as: :language
  element :ATTRIBUTIONS,      as: :radTitleAttributionsAndConjectures
  element :FINDAID_GRP,       as: :findingAids # FIXME: use sub-element: FINDAID
  element :OTHER_CODES,       as: :alternativeIdentifiers
  element :AV_NUMBER,         as: :alternativeIdentifiers
  element :LOC_OF_ORIGINAL,   as: :locationOfOriginals
  element :CONSERVATION,      as: :radNoteConservation
end