$webRequest = Invoke-WebRequest -Uri "http://nav-deckofcards.herokuapp.com/shuffle"

$outputJSON = $webRequest.Content

$Output = ConvertFrom-Json -InputObject $outputJSON

$string = $null
#$string.GetType()

foreach ($card in $Output){
    $string = $string + "$($card.suit[0])" + "$($card.value)" + ","
}
#remove last character 
$string = $string.Substring(0,$string.Length-1)

Write-host "Kortstokk:" $string