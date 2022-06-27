$path = "C:\TestData\6-15-2022-Databricks test\793-6-12\793"
$path2 = "C:\TestData\6-15-2022-Databricks test\793-6-12\793\Converted"
cd $path
$changeDateTo = "2022-06-11"
$stopAfter = 2000

$files = Get-Content -Path "*.txt" -Raw

$i = 0

foreach($f in $files){

    if($i -eq $stopAfter){
       break
    } 

    #Write-Host $f

    [xml]$xml = $f
    Write-Host $xml
    $id = "test.xml"
    try{
        $nodes =  $xml.SelectNodes("//PublixPay")
        $id = $nodes.PublixPayQRCode           
    }catch{
        Write-Host "1st try catch failed"
    }

    
    try{
        $nodes =  $xml.SelectNodes("//TicketStart")
        foreach ($node in $nodes) {        
            $node.BusinessDate = $changeDateTo
        }    
    }catch{
     Write-Host "2nd try catch failed"
    }

    try{
        $nodes =  $xml.SelectNodes("//Trailer")
        foreach ($node in $nodes) {        
            $node.ReceiptDate = $changeDateTo
        }    
    }catch{
     Write-Host "2nd try catch failed"
    }

     try{
        $nodes =  $xml.SelectNodes("//TicketEnd")
        foreach ($node in $nodes) {        
            $node.BusinessDate = $changeDateTo
        }    
    }catch{
     Write-Host "2nd try catch failed"
    }

    Write-Host $id 
    $id2 = $id.Substring(0,$id.Length-1)
    Write-Host $id2 
    $path3 = $path2 + "\" + $id2 + "-12345678-123456.txt";    
    Write-Host $path3

    $xml.Save($path3)
    $i++;
}




