-- | Basic players definitions.
module Content.ModeKindPlayer
  ( playerHero, playerMerchant, playerChaos, playerTechCult, playerHorror, playerSpawn,
    hiHero, hiDweller
  ) where

import qualified Data.EnumMap.Strict as EM
import Data.List

import Game.LambdaHack.Common.Ability
import Game.LambdaHack.Common.Dice
import Game.LambdaHack.Common.Misc
import Game.LambdaHack.Content.ModeKind

playerHero, playerMerchant, playerChaos, playerHorror, playerTechCult, playerSpawn :: Player Dice

playerHero = Player
  { fname = "Space Privateers"
  , fgroup = "hero"
  , fskillsOther = allSkills
  , fcanEscape = True
  , fneverEmpty = True
  , fhiCondPoly = hiHero
  , fhasNumbers = True
  , fhasGender = True
  , ftactic = TFollow
  , fentryLevel = -1
  , finitialActors = 3
  , fleaderMode = LeaderUI $ AutoLeader False False
  , fhasUI = True
  }

playerMerchant = Player
  { fname = "Merchant Mariners"
  , fgroup = "merchant"
  , fskillsOther = meleeAdjacent
  , fcanEscape = False
  , fneverEmpty = False
  , fhiCondPoly = hiDweller
  , fhasNumbers = False
  , fhasGender = True
  , ftactic = TPatrol
  , fentryLevel = -1
  , finitialActors = 3
  , fleaderMode = LeaderAI $ AutoLeader True False
  , fhasUI = False
  }

playerChaos = Player
  { fname = "Forces of Chaos"
  , fgroup = "chaos"
  , fskillsOther = _meleeAndRanged
  , fcanEscape = False
  , fneverEmpty = False
  , fhiCondPoly = hiDweller
  , fhasNumbers = False
  , fhasGender = True
  , ftactic = TExplore
  , fentryLevel = -1
  , finitialActors = 3
  , fleaderMode = LeaderAI $ AutoLeader True False
  , fhasUI = False
  }

playerSpawn = Player
  { fname = "Spawns of Warp"
  , fgroup = "spawn"
  , fskillsOther = animalSkills
  , fcanEscape = False
  , fneverEmpty = False
  , fhiCondPoly = hiDweller
  , fhasNumbers = False
  , fhasGender = False
  , ftactic = TRoam
  , fentryLevel = -2
  , finitialActors = 3
  , fleaderMode = LeaderAI $ AutoLeader True False
  , fhasUI = False
  }

playerTechCult = Player
  { fname = "Tech Cult"
  , fgroup = "tech"
  , fskillsOther = techSkills
  , fcanEscape = False
  , fneverEmpty = True
  , fhiCondPoly = hiDweller
  , fhasNumbers = False
  , fhasGender = False
  , ftactic = TFollow
  , fentryLevel = -2
  , finitialActors = 4
  , fleaderMode = LeaderAI $ AutoLeader True False
  , fhasUI = False
  } -- TODO: change fleaderMode = LeaderAI $ AutoLeader False True

-- | A special player, for summoned actors that don't belong to any
-- of the main players of a given game. E.g., animals summoned during
-- a duel game between two hero players land in the horror faction.
-- In every game, either all factions for which summoning items exist
-- should be present or a horror player should be added to host them.
-- Actors that can be summoned should have "horror" in their @ifreq@ set.
playerHorror = Player
  { fname = "Horrors of Warp"
  , fgroup = "horror"
  , fskillsOther = zeroSkills
  , fcanEscape = False
  , fneverEmpty = False
  , fhiCondPoly = []
  , fhasNumbers = False
  , fhasGender = False
  , ftactic = TPatrol
  , fentryLevel = -3
  , finitialActors = 0
  , fleaderMode = LeaderNull
  , fhasUI = False
  }

victoryOutcomes :: [Outcome]
victoryOutcomes = [Conquer, Escape]

hiHero, hiDweller :: HiCondPoly

-- Heroes rejoice in loot.
hiHero = [ ( [(HiLoot, 1)]
           , [minBound..maxBound] )
         , ( [(HiConst, 1000), (HiLoss, -100)]
           , victoryOutcomes )
         ]

-- Spawners or skirmishers get no points from loot, but try to kill
-- all opponents fast or at least hold up for long.
hiDweller = [ ( [(HiConst, 1000)]  -- no loot
              , victoryOutcomes )
            , ( [(HiConst, 1000), (HiLoss, -10)]
              , victoryOutcomes )
            , ( [(HiBlitz, -100)]
              , victoryOutcomes )
            , ( [(HiSurvival, 100)]
              , [minBound..maxBound] \\ victoryOutcomes )
            ]

minusHundred, meleeAdjacent, _meleeAndRanged, animalSkills, techSkills, allSkills :: Skills

-- To make sure weak items can't override move-only-leader, etc.
minusHundred = EM.fromList $ zip [minBound..maxBound] [-100, -100..]

meleeAdjacent = addSkills minusHundred
                $ EM.fromList $ zip [AbWait, AbMelee] [-101, -101..]

-- Melee and reaction fire.
_meleeAndRanged = addSkills minusHundred
                  $ EM.fromList $ zip [AbWait, AbMelee, AbProject] [-101, -101..]

animalSkills = addSkills minusHundred
               $ EM.fromList $ zip [AbMove, AbMelee, AbAlter, AbWait, AbTrigger] [-101, -101..]

techSkills = addSkills minusHundred
             $ EM.fromList $ zip [AbMove, AbMelee, AbProject, AbAlter, AbWait] [-101, -101..]

allSkills = addSkills minusHundred
            $ EM.fromList $ zip [AbMove, AbMelee, AbProject, AbAlter, AbWait, AbTrigger] [-101, -101..]
