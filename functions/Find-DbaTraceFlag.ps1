Function Find-DbaTraceFlag
{
<#
.SYNOPSIS
Find a trace flag description, scope or Id by searching the trace flag index. 

.DESCRIPTION
Searches through a JSON file of trace flags for an Id, Name, or parsing the description to see if you can find what you're looking for.

.PARAMETER Description
Finds all commands tagged with this auto-populated tag

.PARAMETER Scope
Finds all commands tagged with this auto-populated tag

.PARAMETER Id
Finds all commands tagged with this author

.NOTES
Tags: find
Author: Mitchell Hamann, @SirCaptainMitch, www.mitchellhamann.com

dbatools PowerShell module (https://dbatools.io, clemaire@gmail.com)
Copyright (C) 2016 Chrissy LeMaire

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

.LINK
https://dbatools.io/Find-DbaTraceFlag

.EXAMPLE
Find-DbaCommand "snapshot"

For lazy typers: finds all commands searching the entire help for "snapshot"

#>
	[CmdletBinding(SupportsShouldProcess = $true)]
	Param (
		[String]$Description,
		[String[]]$Scope,
		[String]$Id
	)
	BEGIN
	{				
		$moduledirectory = (Get-Module -Name dbatools).ModuleBase
        $idxfile = "$moduledirectory\bin\TraceFlag-index.json"
	}
	PROCESS
	{
			
		$consolidated = Get-Content -Raw $idxfile | ConvertFrom-Json
		$result = $consolidated

		if ($Pattern.length -gt 0)
		{
			$result = $result | Where-Object Description -Contains $Description
		}
		
		if ($Name.length -gt 0)
		{
			foreach ($t in $Tag)
			{
				$result = $result | Where-Object Name -contains $t
			}
		}
		
		if ($Id.length -gt 0)
		{
			$result = $result | Where-Object TraceFlagId -eq $Id
		}
		
		Select-DefaultView -InputObject $result -Property TraceFlagId, Scope, Description
	}
}
