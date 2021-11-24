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


$blackjack = 21
$stopDraw = 17
$turn = 4

while ((($(SumCards($meg))) -lt $blackjack) -and (($(SumCards($Magnus))) -lt $blackjack)){
    
    #kjøre test om meg skal trekke
    if (($(SumCards($meg))) -lt $stopDraw){
        $meg += $cards[$turn]
        $turn += 1
    }
    elseif(($(SumCards($Magnus))) -lt $stopDraw){
        $Magnus += $cards[$turn]
        $turn += 1
    }
    else {
        break
    }
}


$Vinneren = ""

# $SumMeg = 1
# $SumMagnus = 12

$SumMeg = $(SumCards($meg))
$SumMagnus = $(SumCards($Magnus))

if (($SumMeg -gt $blackjack) -and ($SumMagnus -gt $blackjack)){
    $Vinneren = "Ingen, begge over"
}
elseif ($SumMeg -eq $SumMagnus){
    $Vinneren = "Draw"
}
elseif ((($SumMeg -gt $SumMagnus) -or ($SumMagnus -gt 22)) -and ($SumMeg -lt 22)) {
    $Vinneren = "Meg"
}
elseif ($SumMagnus -lt 22) {
    $Vinneren = "Magnus"
}

#  Write-Host $Vinneren -ForegroundColor Green


Result -kortmeg $meg -kortMagnus $Magnus -Vinner $Vinneren