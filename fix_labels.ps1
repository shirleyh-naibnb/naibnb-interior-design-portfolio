Set-StrictMode -Off
$utf8 = [System.Text.Encoding]::UTF8
$path = "C:\Users\malay\Documents\naibnb-portfolio\index.html"
$lines = [System.Collections.Generic.List[string]]([System.IO.File]::ReadAllLines($path, $utf8))

$labels = @(
    "Living Room","Tea Corner","Tatami Area","Bedroom 2","Tea Corner",
    "Living Room","Living Room","Living Room","Living Room","Living Room",
    "Living Room","Living Room","Living Room","Kitchen","Interior Detail",
    "Tatami Area","Tatami Area","Tea Corner","Tatami Area","Tea Corner",
    "Tea Corner","Tatami Area","Tatami Area","Tatami Area","City View",
    "Tatami Area","Zen Garden","Tatami Area","Tatami Area","Tatami Area",
    "Tatami Area","Master Bedroom","Master Bedroom","Master Bedroom","Master Bedroom",
    "Master Bedroom","Master Bedroom","Bedroom 2","Bedroom 2","Bedroom 2",
    "Bedroom 2","Bathroom","Living Room Bathroom","Master Bedroom Bathroom"
)

# Find car11 carousel start
$car11Start = -1
for ($i = 0; $i -lt $lines.Count; $i++) {
    if ($lines[$i] -match 'id="car11"') { $car11Start = $i; break }
}
Write-Host "car11 starts at line $($car11Start+1)"

# Replace labels within car11 section only
$labelIdx = 0
for ($i = $car11Start; $i -lt $lines.Count -and $labelIdx -lt $labels.Count; $i++) {
    if ($lines[$i] -match 'class="car-room-label"') {
        $lines[$i] = [System.Text.RegularExpressions.Regex]::Replace($lines[$i], '(?<=class="car-room-label">)[^<]*', $labels[$labelIdx])
        $labelIdx++
    }
    if ($lines[$i] -match 'id="car11-counter"') { break }
}

Write-Host "Updated $labelIdx labels"
[System.IO.File]::WriteAllLines($path, $lines, $utf8)
Write-Host "Done"
