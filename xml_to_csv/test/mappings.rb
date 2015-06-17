@mappings = {
	:name => {
		:map => {
			:element => 'NAME',
			:map => ['FIRST_NAME', 'LAST_NAME'],
			:concatenator => ' '
		},
		:concatenator => '!'
	},
	:contact => {
		:map => ['EMAIL', 'PHONE'],
		:concatenator => '|',
	},
	:nested => {
		:map => {
			:element => 'NESTED',
			:map => {
				:element => 'NESTEDDATA',
				:map => ['MORENESTING'],
				:concatenator => '#'
			},
			:concatenator => '#'
		},
		:concatenator => '#'
	}
}