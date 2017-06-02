function Get-DbaTraceFlag {
	<#
		.SYNOPSIS
			Function to get all Active global or session Traceflags 

		.DESCRIPTION
			The Get-DbaTraceFlag function returns a list of currently active Global and session traceflags on the server passed. 

		.PARAMETER SqlInstance
			The SQL Server instance, or instances.You must have sysadmin access and server version must be SQL Server version 2000 or higher.

		.PARAMETER SqlCredential
			Allows you to login to servers using SQL Logins as opposed to Windows Auth/Integrated/Trusted.		

		.NOTES
			Author: Mitchell Hamann (@SirCaptainMitch)

			Website: https://dbatools.io
			Copyright: (C) Chrissy LeMaire, clemaire@gmail.com
			License: GNU GPL v3 https://opensource.org/licenses/GPL-3.0

		.LINK
			https://dbatools.io/Get-DbaTraceFlag

		.EXAMPLE
			Get-DbaLogin -SqlInstance sql2016

			Gets all the logins from server sql2016 using NT authentication and returns the SMO login objects
		
	#>
	[CmdletBinding()]
	Param (
		[parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true)]
		[Alias("ServerInstance", "SqlServer")]
		[DbaInstanceParameter[]]$SqlInstance,
		[PSCredential][System.Management.Automation.CredentialAttribute()]
		$SqlCredential
	)

	process {
		foreach ($Instance in $sqlInstance)
        {
            try {
				Write-Message -Level Verbose -Message "Connecting to $instance"
				$server = Connect-SqlInstance -SqlInstance $instance -SqlCredential $SqlCredential
			}
			catch {
				Stop-Function -Message "Failed to connect to: $instance" -Continue -Target $instance
			}

		} #foreach instance
	} #process
} #function