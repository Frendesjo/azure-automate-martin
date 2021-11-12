param (
    [Parameter ()]
    [String]
    $url = "http://nav-deckofcards.herokuapp.com/shuffle"
)

$ErrorActionPreference = [System.Management.Automation.ActionPreference]::Stop


$webRequest = Invoke-WebRequest -Uri $url

$outputJSON = $webRequest.Content

$Output = ConvertFrom-Json -InputObject $outputJSON

$string = $null
#$string.GetType()

foreach ($card in $Output){
    $string = $string + "$($card.suit[0])" + "$($card.value)" + ","
}
#remove last character 
$string = $string.Substring(0,$string.Length-1)


####Oppgave 5


$Sum = [int]"0"
$Sum.GetType()


foreach ($card in $Output){

    $CardValue = $card.value

    if (($CardValue -eq "K") -or ($CardValue -eq "Q") -or ($CardValue -eq "J")) {
        $CardValue = 10
    }
    elseif ($CardValue -eq "A") {
        $CardValue = 11
    }

    #switch to integer
    $CardValue = [int]$CardValue

    $Sum = $Sum + $CardValue
}




Write-host "Kortstokk:" $string
Write-host "Poengsum:" $Sum