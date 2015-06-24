@mappings = {
	:legacyId => {
		:map => ['REFD']
	},
	:parentId => {
		:map => ['REFD_HIGHER']
	},
	:title => {
		:map => ['TITLE']
	},
	:alternateTitle => {
		:map => ['PARALLEL_TITLE']
	},
	:radTitleStatementOfResponsibility => {
		:map => ['STATEMENT_RESP']
	},
	:radTitleAttributionsAndConjectures => {
		:map => ['ATTRIBUTIONS', 'TITLE_NOTES'],
		:concatenator => '\n'
	},
	:levelOfDescription => {
		:map => ['LEVEL_DESC']
	},
	:identifier => {
		:map => ['REFD'],
		:concatenator => '|'
	},
	:creators => {
		:map => {
			:element => "ORIGINATION_GRP",
			:map => ['*']
		}
	},
	:creatorDates => {
		:map => ['DATE_CR_INC', 'DATE_CR_PRED'],
		:concatenator => '|'
	},
	:extentAndMedium => {
		:map => ['PHYSICAL_DESC']
	},
	:radPublishersSeriesNote => {
		:map => ['PUBLISHER_SERIES'],
		:concatenator => '\n'
	},
	:radNoteOnPublishersSeries => {
		:map => ['PUBLISHER_SERIES'],
		:concatenator => '|'
	},
	:archivalHistory => {
		:map => ['CUSTODIAL_HIST']
	},
	:scopeAndContent => {
		:map => ['SCOPE']
	},
	:physicalCharacteristics => {
		:map => ['PHYSICAL_COND', 'CONDITION_NOTES']
	},
	:acquisition => {
		:map => ['IMM_SOURCE_ACQ']
	},
	:arrangement => {
		:map => ['ARRANGEMENT']
	},
	:language => {
		:map => ['LANGUAGE_MAT, LANGUAGE']
	},
	:languageNote => {
		:map => ['LANGUAGE_NOTES']
	},
	:locationOfCopies => {
		:map => {
			:element => "AVAILABILITY",
			:map => ["OTHER_FORMATS"]
		}
	},
	:locationOfOriginals => {
		:map => ['LOC_OF_ORIGINAL']
	},
	:accessConditions => {
		:map => ['RESTRICTIONS']
	},
	:reproductionConditions => {
		:map => ['TERMS_GOV_USE']
	},
	:findingAids => {
		:map => {
			:element => 'FINDAID_GRP',
			:map => ['FINDAID']
		}
	},
	:relatedUnitsOfDescription => {
		:map => ['ASSOCIATED_MAT', 'RELATED_MAT'],
		:concatenator => '\n'
	},
	:accruals => {
		:map => ['ACCRUALS_NOTES']
	},
	:radGeneralMaterialDesignation => {
		:map => ['MEDIUM', 'SMD', 'FORM']
	},
	:radNoteAccompanyingMaterial => {
		:map => ['ACCOMPANYING_MAT']
	},
	:radNoteConservation => {
		:map => ['CONSERVATION']
	},
	:radNotePhysicalDescription => {
		:map => ['PHYS_DESC_NOTES']
	},
	:radNoteGeneral => {
		:map => ['NOTES', 'REFERENCE_REF', 'CREDITS', 'MODE_OR_PROCESS', 'TECHNICAL_SPECS', 'SOUND_CHAR'],
		:concatenator => '\n'
	},
	:radNoteRights => {
		:map => ['COPYRIGHT_NOTES']
	},
	:placeAccessPoints => {
		:map => ['LOC_GEOG']
	},
	:subjectAccessPoints => {
		:map => ['SUBJECT', 'INDEXSUB'],
		:concatenator => '|'
	},
	:nameAccessPoints => {
		:map => ['INDEXPROV', 'PUBLISHER', 'ARCHITECT', 'OTHERS_RESP'],
		:concatenator => '|'
	},
	:publicationStatus => {
		:map => ['WEBD']
	},
	:archivistNote => {
		:map => ['COMMENTS_DESC', 'BOX_NO'],
		:concatenator => '\n'
	},
	:radNoteSignatures => {
		:map => ['SIGNATURES']
	},
	:radEdition => {
		:map => ['EDITION']
	},
	:accessionNumber => {
		:map => {
			:element => 'ACCESSION_GRP',
			:map => ['D_ACCNO'],
			:concatenator => '\n'
		},
		:concatenator => '\n'
	}
}