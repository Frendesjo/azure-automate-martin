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

# Write-host "Kortstokk: $(Cardprint($Cards))"
# write-host "Poengsum: $(SumCards($Cards))"
# write-host ""



# $meg = $Cards[0..1]
# $Magnus = $Cards[2..$Cards.Length]

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

#Result -kortMagnus $Magnus -kortmeg $meg

# $blackjack = 21
#  $draw = 42

#kjører hele "gamle" if i en ny if for å sjekke draw først

# if ($(Sumcards($cards)) -eq $draw) {
#     Result -kortmeg $meg -kortMagnus $Magnus -Vinner "Draw"
# }
# else
# {
#     if ($(Sumcards($meg)) -eq $blackjack) {
#         Result -kortmeg $meg -kortMagnus $Magnus -Vinner "Meg"
#     }
#     else {
#         Result -kortmeg $meg -kortMagnus $Magnus -Vinner "Magnus"
#     }
# }


##### Oppgave 8

# Write-host "Kortstokk: $(Cardprint($Cards))"
# write-host "Poengsum: $(SumCards($Cards))"
# write-host ""


# $meg = $Cards[0..1]
# $Magnus = $Cards[2..3]

# #begynner på kort 5, array plass 4
# $turn = 4

# while (($(Sumcards($meg))) -lt $blackjack){
#     $meg += $cards[$turn]
#     $turn += 1
# }

# if ($(Sumcards($meg)) -gt $blackjack){
#     Result -kortmeg $meg -kortMagnus $Magnus -Vinner "Magnus"
# }


##### Oppgave 9

#  Write-host "Kortstokk: $(Cardprint($Cards))"
#  write-host "Poengsum: $(SumCards($Cards))"
#  write-host ""


# $meg = $Cards[0..1]
# $Magnus = $Cards[2..3]

# #begynner på kort 5, array plass 4
# $turn = 4

# while (($(Sumcards($meg))) -lt 17){
#     $meg += $cards[$turn]
#     $turn += 1

#     # $test = Sumcards($meg)
#     # write-host $test -ForegroundColor Red
# }


# while (($(SumCards($Magnus))) -lt $blackjack ){
#     $Magnus += $cards[$turn]
#     $turn += 1

    # $testmagnus = Sumcards($Magnus)
    # write-host $testmagnus -ForegroundColor Blue
# }

# Result -kortmeg $meg -kortMagnus $Magnus -Vinner "Meg"


##### Oppgave 10

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
    if (($(SumCards($Magnus))) -lt $stopDraw){
        $Magnus += $cards[$turn]
        $turn += 1
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