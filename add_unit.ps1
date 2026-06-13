Set-StrictMode -Off
$ErrorActionPreference = "Stop"
$q = [char]34
$utf8 = [System.Text.Encoding]::UTF8

$htmlPath = "C:\Users\malay\Documents\naibnb-portfolio\index.html"
$totalPhotos = 44

$roomLabels = @(
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

Write-Host "Reading UTF-8..."
$lines = [System.Collections.Generic.List[string]]([System.IO.File]::ReadAllLines($htmlPath, $utf8))
Write-Host "Lines: $($lines.Count)"
$logoLine = $lines[837]

Write-Host "Building carousel..."
$carLines = [System.Collections.Generic.List[string]]::new()
for ($i = 0; $i -lt $totalPhotos; $i++) {
    $n = "{0:D2}" -f ($i+1)
    $src = "units/AGL-B-41-10/photo-$n.jpg"
    $lbl = $roomLabels[$i]
    $act = if ($i -eq 0) { " active" } else { "" }
    $carLines.Add("    <div class=${q}car-item$act${q}>")
    $carLines.Add("      <img class=${q}car-img${q} src=${q}$src${q}>")
    $carLines.Add("      <div class=${q}car-room-label${q}>$lbl</div>")
    $carLines.Add("    </div>")
}
$dotsHtml = "<div class=${q}car-dots${q}>"
for ($i = 0; $i -lt $totalPhotos; $i++) {
    $act = if ($i -eq 0) { " active" } else { "" }
    $dotsHtml += "<div class=${q}car-dot$act${q} onclick=${q}carGoTo('car11',$i)${q}></div>"
}
$dotsHtml += "</div>"

$slide = [System.Collections.Generic.List[string]]::new()
$slide.Add("  <div class=${q}slide slide-unit${q} data-index=${q}19${q}>")
$slide.Add("    <div class=${q}unit-layout${q}>")
$slide.Add("      <div class=${q}photo-area${q}><div class=${q}carousel${q} id=${q}car11${q} data-cur=${q}0${q} data-total=${q}$totalPhotos${q}>")
$slide.Add("      <div class=${q}car-track${q}>")
foreach ($cl in $carLines) { $slide.Add($cl) }
$slide.Add("    </div>")
$slide.Add("      <button class=${q}car-btn car-prev${q} onclick=${q}carNav('car11',-1)${q}>&#8592;</button>")
$slide.Add("      <button class=${q}car-btn car-next${q} onclick=${q}carNav('car11',1)${q}>&#8594;</button>")
$slide.Add("        $dotsHtml")
$slide.Add("        <div class=${q}car-counter${q} id=${q}car11-counter${q}>1 / $totalPhotos</div>")
$slide.Add("      </div>")
$slide.Add("    </div>")
$slide.Add("      <div class=${q}info-panel${q}>")
$slide.Add("        <div class=${q}panel-accent-bar${q}></div>")
$slide.Add("        <div class=${q}panel-inner${q}>")
$slide.Add("          <div class=${q}style-name${q}>JAPANDI</div>")
$slide.Add("          <div class=${q}style-sub${q}>JAPANESE &amp; SCANDINAVIAN FUSION</div>")
$slide.Add("          <div class=${q}panel-divider${q}></div>")
$slide.Add("          <p class=${q}desc-text${q}>A serene retreat born from the harmony of Japanese wabi-sabi and Scandinavian hygge. Muted earth tones, natural timbers, and purposeful simplicity shape a living space that breathes &#8212; where every detail is chosen with calm and intention.</p>")
$slide.Add("          <div class=${q}panel-divider${q}></div>")
$slide.Add("          <div class=${q}meta-row${q}>")
$slide.Add("            <div class=${q}meta-label${q}>LAYOUT</div>")
$slide.Add("            <div class=${q}meta-value${q}>2 Bedroom &amp; 2 Bathroom</div>")
$slide.Add("          </div>")
$slide.Add("          <div class=${q}panel-divider${q}></div>")
$slide.Add("          <p class=${q}pkg-desc${q}>Artisan-crafted furnishings, premium natural materials, and elevated detailing &#8212; a Japandi showcase unit of the highest order.</p>")
$slide.Add("          <div class=${q}panel-divider${q}></div>")
$slide.Add("          <div class=${q}meta-row${q}>")
$slide.Add("            <div class=${q}meta-label${q}>LOCATION</div>")
$slide.Add("            <div class=${q}meta-value location-value${q}>")
$slide.Add("              <span class=${q}loc-unit${q}>AGL B-41-10</span>")
$slide.Add("              <span class=${q}loc-building${q}>AGILE BUKIT BINTANG</span>")
$slide.Add("              <span class=${q}loc-address${q}>3, Jalan Delima, Bukit Bintang, 55100 Kuala Lumpur</span>")
$slide.Add("            </div>")
$slide.Add("          </div>")
$slide.Add("          <div class=${q}panel-divider${q}></div>")
$slide.Add("          <div class=${q}meta-label${q} style=${q}margin-bottom:10px${q}>VIRTUAL TOUR</div>")
$slide.Add("          <a href=${q}https://my.matterport.com/show/?m=5ESygVpKhoh${q} target=${q}_blank${q} class=${q}matterport-btn${q}>")
$slide.Add("            View on Matterport <span class=${q}btn-arrow${q}>&#8599;</span>")
$slide.Add("          </a>")
$slide.Add($logoLine)
$slide.Add("        </div>")
$slide.Add("      </div>")
$slide.Add("    </div>")
$slide.Add("  </div>")
$slide.Add("")

# Unit counts
for ($i = 570; $i -le 585; $i++) {
    $lines[$i] = $lines[$i] -replace '11 Units', '12 Units'
    $lines[$i] = $lines[$i] -replace '11 thoughtfully designed units', '12 thoughtfully designed units'
}
$lines[720] = $lines[720] -replace '>4<', '>5<'

# sf-unit-item insertion at 733
$sfNew = [System.Collections.Generic.List[string]]::new()
$sfNew.Add("          </div><div class=${q}sf-unit-item${q}>")
$sfNew.Add("            <span class=${q}sf-unit-code${q}>AGL B-41-10</span>")
$sfNew.Add("            <span class=${q}sf-unit-layout${q}>2 Bedroom &amp; 2 Bathroom</span>")
$sfNew.Add("            <span class=${q}sf-unit-bld${q}>AGILE BUKIT BINTANG</span>")
$sfNew.Add("            <span class=${q}sf-unit-addr${q}>3, Jalan Delima, Bukit Bintang, 55100 Kuala Lumpur</span>")
$lines.InsertRange(733, $sfNew)

# idx-unit-row insertion in JAPANDI (index 626 after sfNew which is at 733, so 626 unchanged)
$lines[626] = "        </div>"
$nb = [System.Collections.Generic.List[string]]::new()
$nb.Add("        <div class=${q}idx-unit-row${q} onclick=${q}goTo(19)${q}>")
$nb.Add("          <div class=${q}idx-unit-left${q}>")
$nb.Add("            <div class=${q}idx-unit-code${q}>AGL B-41-10</div>")
$nb.Add("            <div class=${q}idx-unit-layout${q}>2 Bedroom &amp; 2 Bathroom &middot; AGILE BUKIT BINTANG</div>")
$nb.Add("          </div>")
$nb.Add("          <div class=${q}idx-unit-right${q}>")
$nb.Add("            <span class=${q}idx-pkg-badge elite${q}>ELITE</span>")
$nb.Add("            <span class=${q}idx-arrow${q}>&#8594;</span>")
$nb.Add("          </div>")
$nb.Add("        </div>")
$nb.Add("        </div>")
$lines.InsertRange(627, $nb)
Write-Host "ToC inserted"

# Back-cover: original 2369, +5(sfNew)+11(nb)=+16 -> 2385
$lines[2385] = $lines[2385] -replace 'data-index="19"', 'data-index="20"'
Write-Host "Back-cover: $($lines[2385].Substring(0,[Math]::Min(60,$lines[2385].Length)))"

# Insert slide before back-cover
$lines.InsertRange(2385, $slide)
Write-Host "Slide inserted ($($slide.Count) lines)"

# Counter at original 2497, +16+slide.Count
$cIdx = 2497 + 16 + $slide.Count
$lines[$cIdx] = $lines[$cIdx] -replace '1 / 20', '1 / 21'
Write-Host "Counter: $($lines[$cIdx])"

# Nav dots at original 2495, +16+slide.Count
$dIdx = 2495 + 16 + $slide.Count
$dl = $lines[$dIdx]
$newDot = "<div class=${q}dot${q} onclick=${q}goTo(19)${q}></div>"
$dl = $dl -replace '(<div class="dot" onclick="goTo\(19\)"></div>)', "$newDot`$1"
$dl = $dl -replace '(goTo\(19\)"></div>)\s*$', 'goTo(20)"></div>'
$lines[$dIdx] = $dl
Write-Host "Dots updated"

# Hamburger nav
$navTo6Idx = -1
for ($i = 2600; $i -lt $lines.Count; $i++) {
    if ($lines[$i] -match 'navTo\(6\)') { $navTo6Idx = $i; break }
}
$navCloseIdx = -1
for ($i = $navTo6Idx+1; $i -lt [Math]::Min($navTo6Idx+10,$lines.Count); $i++) {
    if ($lines[$i] -match '^\s+</div></div>\s*$') { $navCloseIdx = $i; break }
}
Write-Host "navTo6 close at $navCloseIdx"
$navNew = [System.Collections.Generic.List[string]]::new()
$navNew.Add("        </div><div class=${q}hd-item${q} onclick=${q}navTo(19)${q}>")
$navNew.Add("          <div class=${q}hd-item-left${q}>")
$navNew.Add("            <div class=${q}hd-item-code${q}>AGL B-41-10</div>")
$navNew.Add("            <div class=${q}hd-item-layout${q}>2 Bedroom &amp; 2 Bathroom &middot; AGILE BUKIT BINTANG</div>")
$navNew.Add("          </div>")
$navNew.Add("        </div></div>")
$lines.RemoveAt($navCloseIdx)
$lines.InsertRange($navCloseIdx, $navNew)
Write-Host "Hamburger nav inserted"

# const total
for ($i = 2750; $i -le 2860; $i++) {
    if ($lines[$i] -match 'const total = 20') {
        $lines[$i] = $lines[$i] -replace 'const total = 20', 'const total = 21'
        Write-Host "const total fixed at line $($i+1)"; break
    }
}

Write-Host "Writing $($lines.Count) lines..."
[System.IO.File]::WriteAllLines($htmlPath, $lines, $utf8)
Write-Host "Done."

