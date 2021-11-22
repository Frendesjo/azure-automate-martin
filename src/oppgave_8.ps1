param (
    [Parameter ()]
    [String]
    $Kortstokk  = "https://azure-gvs-test-cases.azurewebsites.net/api/taperMeg"
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

$blackjack = 21
$draw = 42

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

Write-host "Kortstokk: $(Cardprint($Cards))"
write-host "Poengsum: $(SumCards($Cards))"
write-host ""


$meg = $Cards[0..1]
$Magnus = $Cards[2..3]

#begynner på kort 5, array plass 4
$turn = 4

while (($(Sumcards($meg))) -lt $blackjack){
    $meg += $cards[$turn]
    $turn += 1
}

if ($(Sumcards($meg)) -gt $blackjack){
    Result -kortmeg $meg -kortMagnus $Magnus -Vinner "Magnus"
}