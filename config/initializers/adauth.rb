Adauth.configure do |c|
	# The Domain name of your Domain
	#
	# This is usually my_company.com or my_company.local
	#
	# If you don't know your domain contact your IT support,
	# it will be the DNS suffix applied to your machines
	c.domain = "commercial.demo"

	# Adauth needs a query user to interact with the domain.
	# This user can be anything with domain access
	#
	# If Adauth doesn't work contact your IT support and make sure this account has full query access
	c.query_user = "ldap_lookup"
	c.query_password = "W1ndow$"

	# The IP address or Hostname of a DC (Domain Controller) on your network
	#
	# This could be anything and probably wont be 127.0.0.1
	#
	# Again contact your IT Support if you can't work this out
	c.server = "10.5.36.100"

	# The LDAP base of your domain/intended users
	#
	# For all users in your domain the base would be:
	# dc=example, dc=com
	# OUs can be prepeneded to restrict access to your app
	c.base = "cn=Users,dc=commercial,dc=demo"

	# The port isn't always needed as Adauth defaults to 389 the LDAP Port
	#
	# If your DC is on the other side of a firewall you may need to change the port
	# If your DC is using SSL, the port may be 636.
	#c.port = 389

	# If your DC is using SSL, set encryption to :simple_tls
	#c.encryption = :simple_tls

	# Windows Security groups to allow
	#
	# Only allow members of set windows security groups to login
	#
	# Takes an array for group names
	c.allowed_groups = ["Commercial Lab Admins"]

	# Windows Security groups to deny
	#
	# Only allow users who aren't in these groups to login
	#
	# Takes an array for group names
	#c.denied_groups = ["Group1", "Group2"]
end
