<#
.SYNOPSIS
This script retrieves volume information.

.DESCRIPTION
This script uses the Get-WmiObject cmdlet to retrieve volume information. It displays 
the volume label, name, percent full, free space (KiB), and size (KiB) for volumes 
with a size of at least 1,000,000 KiB by default.

.PARAMETER MinimumSize
The minimum size of the volumes to retrieve information for, in KiB. The default is 1,000,000 KiB.

.PARAMETER NoSizeFilter
If this switch is specified, the script retrieves information for all volumes, regardless of size.

.PARAMETER HumanReadable
If this switch is specified, the script displays sizes in a human-readable format (KiB, MiB, GiB, etc.)

.EXAMPLE
.\GetVolumeInfo.ps1 -MinimumSize 500000

This command retrieves information for volumes with a size of at least 500,000 KiB.

.EXAMPLE
.\GetVolumeInfo.ps1 -NoSizeFilter

This command retrieves information for all volumes.

.EXAMPLE
.\GetVolumeInfo.ps1 -HumanReadable

This command retrieves information for volumes and displays sizes in a human-readable format.

#>

param (
    [Parameter(Position=0)]
    [int]$MinimumSize = 1000000,

    [Parameter(Position=1)]
    [switch]$NoSizeFilter,

    [Parameter(Position=2)]
    [switch]$HumanReadable
)

function ConvertTo-HumanReadable {
    param(
        [Parameter(Position=0, Mandatory=$true)]
        [double]$SizeInBytes
    )

    if ($SizeInBytes -gt 1GiB) {
        return "{0:N2} GiB" -f ($SizeInBytes / 1GiB)
    } elseif ($SizeInBytes -gt 1MiB) {
        return "{0:N2} MiB" -f ($SizeInBytes / 1MiB)
    } elseif ($SizeInBytes -gt 1KiB) {
        return "{0:N2} KiB" -f ($SizeInBytes / 1KiB)
    } else {
        return "{0} Bytes" -f $SizeInBytes
    }
}

Get-WmiObject Win32_Volume | ForEach-Object {
    $Label = $_.Label
    $Name = $_.Name
    $Size = $_.Capacity
    $FreeSpace = $_.FreeSpace
    $PercentFull = "{0:N2}" -f (($Size - $FreeSpace) / $Size * 100)

    if ($HumanReadable) {
        $Size = ConvertTo-HumanReadable $Size
        $FreeSpace = ConvertTo-HumanReadable $FreeSpace
    } else {
        $Size = ($Size / 1KiB).ToString("N0")
        $FreeSpace = ($FreeSpace / 1KiB).ToString("N0")
    }

    New-Object PSObject -Property @{
        Label = $Label
        Name = $Name
        "Percent Full" = $PercentFull
        "Free Space" = $FreeSpace
        "Size" = $Size
    }
} | Where-Object {
    $NoSizeFilter -or $_.Size -ge $MinimumSize
} | Select-Object Label, Name, "Percent Full", "Free Space", "Size"
