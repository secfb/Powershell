FUNCTION Digest-IPAMNetworks {
<#
.Synopsis 
	Scans InfoBlox IPAM exports for specific types and extracts required fields and comment.

.Description 
    Scans InfoBlox IPAM exports for specific types and extracts required fields and comment. Use the -c switch to scan for network containers, ohterwise defaults to networks.

.Parameter Containers  
    Alias is "c". This changes the script to digest networkcontainer entries instead of network entries.

.Example 
    Digest-IPAMNetworks -Path "C:\temp\Allnetworks.csv"
    Digest-IPAMNetworks -Path "C:\temp\Allnetworks.csv" -c
    Digest-IPAMNetworks -Path "C:\temp\Allnetworks.csv" -c | export-csv networkcontainers.csv

.Notes 
    Updated: 2017-07-05
    LEGAL: Copyright (C) 2017  Anthony Phipps
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
    
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#>

    PARAM(
    	[Parameter(ValueFromPipeline=$True, Position = 0)]
		$Entry,
        [Parameter(Position = 1)]
        [Alias("containers")]
        [switch]$c
    );

	BEGIN{

	};

    PROCESS{
        if($c){
            $Entry | Where-Object { ($_ -like "networkcontainer,*") } | ConvertFrom-String -Delimiter "," -PropertyNames header-networkcontainer, address*, netmask*, 4, 5, 6, 7, comment | Select-Object header-networkcontainer, address*, netmask*, comment

        }

        else
        {
            $Entry | Where-Object { ($_ -like "network,*") } | ConvertFrom-String -Delimiter "," -PropertyNames header-network, address*, netmask*, 4, 5, 6, 7, 8, comment | Select-Object header-network, address*, netmask*, comment
        };
    };

    END{
        
    };
};
