. (Join-Path $PSScriptRoot "Scraping Champlain Classes.ps1")

$FullTable = gatherClasses

$FullTable = daysTranslator $FullTable

$FullTable | Select-Object "Class Code", Instructor, Location, Days, "Time Start", "Time End" | where { $_.Instructor -ilike "Furkan Paligu" }

$FullTable | where{ ($_.Location -ilike "JOYC 310") -and ($_.days -contains "Monday") } | Sort-Object "Time Start" | select "Time Start", "Time End", "Class Code"

$ITSInstructors = $FullTable | where { ($_."Class Code" -ilike "SYS*") -or `
                                       ($_."Class Code" -ilike "NET*") -or `
                                       ($_."Class Code" -ilike "SEC*") -or `
                                       ($_."Class Code" -ilike "FOR*") -or `
                                       ($_."Class Code" -ilike "CSI*") -or `
                                       ($_."Class Code" -ilike "DAT*") } `
                             | Select-Object "Instructor" `
                             | Sort-Object "Instructor" -Unique

$ITSInstructors

$FullTable | where { $_.Instructor -in $ITSInstructors.Instructor } | Group-Object "Instructor" | Select-Object Count, Name | Sort-Object Count -Descending
