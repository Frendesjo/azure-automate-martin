$webRequest = Invoke-WebRequest -Uri "http://nav-deckofcards.herokuapp.com/shuffle"

$outputJSON = $webRequest.Content

$Output = ConvertFrom-Json -InputObject $outputJSON



foreach ($card in $Output){
    Write-Output "$($card.suit[0]),$($card.value)"

}


$string = "" 

$string.GetType()

foreach ($card in $Output){
    $string = $string + "$($card.suit[0])" + "$($card.value)" + ","
    #exit
}
return $string
