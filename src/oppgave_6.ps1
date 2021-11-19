param (
    [Parameter ()]
    [String]
    $url  = "http://nav-deckofcards.herokuapp.com/shuffle"
)

$ErrorActionPreference = [System.Management.Automation.ActionPreference]::Stop


$webRequest = Invoke-WebRequest -Uri $url

$outputJSON = $webRequest.Content

$Output = ConvertFrom-Json -InputObject $outputJSON


<#region Gammel utskritft versjon. byttet til funksjon lenger ned
$string = $null
#$string.GetType()

foreach ($card in $Output){
    $string = $string + "$($card.suit[0])" + "$($card.value)" + ","
}
#remove last character 
$string = $string.Substring(0,$string.Length-1)
#>

function Cardprint {
    param (
        [Parameter()]
        [Object[]]
        $Output
    )
    #Skrive ut kortstokk
    $cards = @()
    foreach ($card in $Output){
        $cards += ($card.suit[0] + $card.value)
        #$string = $string + "$($card.suit[0])" + "$($card.value)"
    }
    $cards
}


######Oppgave 5

function SumCards {

    #[OutputType([int])]

    $Sum = [int]"0"
    
    #$Sum.GetType()


    foreach ($card in $Output){

        $CardValue = $card.value

        if (($CardValue -eq "K") -or ($CardValue -eq "Q") -or ($CardValue -eq "J")) {
            $CardValue = 10
        }
        elseif ($CardValue -eq "A") {
            $CardValue = 11
        }
        else {
        #switch to integer
        $CardValue = [int]$CardValue
        }

        $Sum += $CardValue
    }
    return $Sum
}

Write-host "Kortstokk: $(Cardprint($Output))"
write-host "Poengsum: $(SumCards)"



#### Oppgave 6


$meg = ""