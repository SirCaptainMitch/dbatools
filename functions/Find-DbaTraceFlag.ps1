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
Find-DbaTraceFlag -Scope query -list

Find all trace flags with a query scope, output as a list instead of a table. 

.EXAMPLE
Find-DbaTraceFlag -Id 9939

Find the trace flag with an Id of 9939, output as a table.

.EXAMPLE
Find-DbaTraceFlag -Description 'parallel'

Find all trace flags with the word parallel in the description.

#>
	[CmdletBinding()]
	Param (
		[String]$Description,
		[String[]]$Scope,
		[String]$Id, 
        [Switch]$List
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

		if ($Description.length -gt 0)
		{
			$result = $result | Where-Object Description -like "*$Description*"
		}
		
		if ($Scope.length -gt 0)
		{
			foreach ($s in $Scope)
			{
				$result = $result | Where-Object Scope -like "*$s*"
			}
		}
		
		if ($Id.length -gt 0)
		{
			$result = $result | Where-Object TraceFlagId -eq $Id
		}
		
        if ($List) 
        { 
           $result | Format-List 
        } else { 
            Select-DefaultView -InputObject $result -Property TraceFlagId, Scope, Description           
        }		
	}
}
