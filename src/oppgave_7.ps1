param (
    [Parameter ()]
    [String]
    $Kortstokk  = "http://nav-deckofcards.herokuapp.com/shuffle"
)

$ErrorActionPreference = [System.Management.Automation.ActionPreference]::Stop


$webRequest = Invoke-WebRequest -Uri $Kortstokk

$outputJSON = $webRequest.Content

$cards = ConvertFrom-Json -InputObject $outputJSON


function Cardprint {
    param (
        [Parameter()]
        [Object[]]
        $Cards
    )
    #Skrive ut kortstokk
    $Deck = @()
    foreach ($card in $Cards){
        $Deck += ($card.suit[0] + $card.value)
    }
    $Deck
}

######Oppgave 5

function SumCards {
    param (
        [Parameter()]
        [Object[]]
        $Cards
    )

    $Sum = 0
    
    foreach ($card in $Cards){

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

# Write-host "Kortstokk: $(Cardprint($Cards))"
# write-host "Poengsum: $(SumCards)"



#### Oppgave 6

# $meg = $Cards[0..1]
# $Cards = $Cards[2..$Cards.Length]
# $Magnus = $Cards[0..1]
# $Cards = $Cards[2..$Cards.Length]

# Write-Host "Meg: $(Cardprint($meg))"
# Write-Host "Magnus $(Cardprint($Magnus))"
# Write-host "Kortstokk: $(Cardprint($Cards))"



#### Oppgave 7

Write-host "Kortstokk: $(Cardprint($Cards))"
write-host "Poengsum: $(SumCards($cards))"