ip_sets = {
  IP-Block = [
    "10.0.1.0/24",
    "10.2.0.0/24"
  ]
  IP-Sloth = [
    "192.168.2.0/24",
    "192.168.3.0/24"
  ] 
	IP-Snake = [
		"172.22.0.32/32",
		"10.1.2.3/32"
	]
}

rule_groups = {
  NetworkRuleGroup = [
    {
      name     = "IP-Block"
      priority = 0
      action   = "block"
      statement = {
        ip_set_reference_statement = [
          "IP-Block"
        ]
      }
    },
    {
      name     = "IP-Allow"
      priority = 1
      action   = "allow"
      statement = {
        ip_set_reference_statement = [
          "IP-Sloth",
					"IP-Snake"
        ]
      }
    },
    {
      name     = "SanctionedCountries"
      priority = 2
      action   = "block"
      statement = {
        geo_match_statement = {
          country_codes = [
            "AF", # Afghanistan
            "BI", # Burundi
            "BY", # Belarus
            "CF", # Central African Republic
            "CG", # Congo
            "CU", # Cuba
            "ET", # Ethiopia
            "IR", # Iran
            "IQ", # Iraq
            "KP", # North Korea
            "LB", # Lebanon
            "LY", # Libya
            "ML", # Mali
            "MM", # Myanmar (Burma)
            "NI", # Nicaragua
            "RU", # Russia
            "SO", # Somalia
            "SS", # South Sudan
            "SD", # Sudan
            "SY", # Syria
            "UA", # Ukraine
            "VE", # Venezuela
            "YE", # Yemen
            "ZW"  # Zimbabwe
          ]
        }
      }
    },
  ]
}
