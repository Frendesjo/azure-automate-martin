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

function Result {
    param (
        [string]
        $Vinner,
        [object[]]
        $kortmeg,
        [Object[]]
        $kortMagnus
    )
    Write-Host "Vinner:" $Vinner
    Write-Host "Magnus | $(Sumcards($kortMagnus)) | $(Cardprint($kortMagnus))"
    Write-Host "Meg | $(Sumcards($kortmeg)) | $(Cardprint($kortmeg))"
}



##### Oppgave 10 Clean

Write-host "Kortstokk: $(Cardprint($Cards))"
Write-host "Poengsum: $(SumCards($Cards))"
Write-host ""


$meg = $Cards[0..1]
$Magnus = $Cards[2..3]

$cards = $cards[4..$cards.Count]

$blackjack = 21


while (($(SumCards($meg))) -lt 17 ){
    $meg += $cards[0]
    $Cards = $Cards[1..$Cards.Count]
}

if (($(SumCards($meg))) -gt $blackjack){
    Result -kortmeg $meg -kortMagnus $Magnus -Vinner "Magnus"
    exit
}

while (($(SumCards($Magnus))) -le ($(SumCards($meg))) ){
    $Magnus += $cards[0]
    $Cards = $Cards[1..$Cards.Count]
}

if (($(SumCards($Magnus))) -gt $blackjack){
    Result -kortmeg $meg -kortMagnus $Magnus -Vinner "Meg"
    exit
}

Result -kortmeg $meg -kortMagnus $Magnus -Vinner "Magnus"
test