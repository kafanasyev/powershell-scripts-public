$path = "C:\TestData\PowerKI-WeeklyData2"
$path2 = "C:\TestData\PowerKI-WeeklyData2\Converted"
cd $path

$files = Get-Content -Path "*.json" -Raw

foreach($f in $files){
$FileContent = $f | ConvertFrom-Json
$id = $FileContent.transactionId
$FileContent = $FileContent | Select-Object * -ExcludeProperty _rid
$FileContent = $FileContent | Select-Object * -ExcludeProperty _self
$FileContent = $FileContent | Select-Object * -ExcludeProperty _etag
$FileContent = $FileContent | Select-Object * -ExcludeProperty _attachments
$FileContent = $FileContent | Select-Object * -ExcludeProperty _ts
$FileContent | ConvertTo-Json | Out-File "$path2\$id.json"
}