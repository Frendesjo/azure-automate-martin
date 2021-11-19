param (
    [Parameter ()]
    [String]
    $Kortstokk  = "http://nav-deckofcards.herokuapp.com/shuffle"
)

$ErrorActionPreference = [System.Management.Automation.ActionPreference]::Stop


$webRequest = Invoke-WebRequest -Uri 'https://azure-gvs-test-cases.azurewebsites.net/api/vinnerMeg'

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
write-host "Poengsum: $(SumCards($Cards))"

$meg = $Cards[0..1]

$Magnus = $Cards[2..$Cards.Length]


function Result {
    param (
        [string]
        $Vinner,
        [object[]]
        $kortmeg,
        [Object[]]
        $kortMagnus
    )
    
    Write-Host "Magnus | $(Sumcards($kortMagnus))"
    Write-Host "Meg | $(Sumcards($kortmeg))"
}

Result -kortMagnus $Magnus -kortmeg $meg