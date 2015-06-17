# @mappings = {
# 	:name => {
# 		:map => {
# 			:element => 'NAME',
# 			:map => ['FIRST_NAME', 'LAST_NAME'],
# 			:concatenator => ' '
# 		},
# 		:concatenator => '!'
# 	},
# 	:contact => {
# 		:map => ['EMAIL', 'PHONE'],
# 		:concatenator => '|',
# 	}
# }
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
		:map => ['OTHER_CODES'],
		:concatenator => '|'
	},
	:creatorDates => {
		:map => ['DATE_CR_INC', 'DATE_CR_PRED'],
		:concatenator => '|'
	},
	:extentAndMedium => {
		:map => ['PHYSICAL_DESC']
	},
	:radPublishersSeriesNote => {
		:map => ['PUBLISHER_SERIES', 'PLACE_OF_PUB', 'EDITION'],
		:concatenator => '\n'
	},
	:radNoteOnPublishersSeries => {
		:map => ['PUBLISHER_SERIES', 'PLACE_OF_PUB', 'EDITION'],
		:concatenator => '|'
	},
	:archivalHistory => {
		:map => ['CUSTODIAL_HIST']
	},
	:scopeAndContent => {
		:map => ['SCOPE']
	},
	:physicalCharacteristics => {
		:map => ['PHYSICAL_COND']
	},
	:acquisition => {
		:map => ['DONOR']
	},
	:arrangement => {
		:map => ['ARRANGEMENT']
	},
	:languageNote => {
		:map => ['LANGUAGE_NOTES']
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
		:map => ['FINDAID']
	},
	:relatedUnitsOfDescription => {
		:map => ['ASSOCIATED_MAT', 'RELATED_MAT'],
		:concatenator => '\n'
	},
	:accruals => {
		:map => ['ACCRUAL_NOTES']
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
		:map => ['NOTES', 'OTHER_FORMATS'],
		:concatenator => '\n'
	},
	:subjectAccessPoints => {
		:map => ['INDEXSUB'],
		:concatenator => '|'
	},
	:nameAccessPoints => {
		:map => ['INDEXPROV', 'PUBLISHER'],
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
	:accessionNumber => {
		:map => ['D_ACCNO']
	}
}