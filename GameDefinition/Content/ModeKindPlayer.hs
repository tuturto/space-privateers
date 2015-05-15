-- | Basic players definitions.
module Content.ModeKindPlayer
  ( playerHero, playerAntiHero, playerMerchant, playerAntiMerchant, playerChaos, playerTechCult, playerHorror, playerSpawn,
    hiHero, hiDweller, hiRaid
  ) where

import qualified Data.EnumMap.Strict as EM
import Data.List

import Game.LambdaHack.Common.Ability
import Game.LambdaHack.Common.Dice
import Game.LambdaHack.Common.Misc
import Game.LambdaHack.Content.ModeKind

playerHero, playerAntiHero, playerMerchant, playerAntiMerchant, playerChaos, playerHorror, playerTechCult, playerSpawn :: Player Dice

playerHero = Player
  { fname = "Space Privateers"
  , fgroup = "hero"
  , fskillsOther = zeroSkills
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

playerAntiHero = playerHero
  { fleaderMode = LeaderAI $ AutoLeader True False
  , fhasUI = False
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
  , ftactic = TFollow  -- TODO: change when implemented TPatrol
  , fentryLevel = -1
  , finitialActors = 3
  , fleaderMode = LeaderAI $ AutoLeader True False
  , fhasUI = False
  }

playerAntiMerchant = playerMerchant
  { fhasUI = True
  , fleaderMode = LeaderUI $ AutoLeader True False
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

playerTechCult = Player
  { fname = "Tech Cult"
  , fgroup = "tech"
  , fskillsOther = zeroSkills
  , fcanEscape = False
  , fneverEmpty = True  -- makes sense, because never spawned
  , fhiCondPoly = hiDweller
  , fhasNumbers = False
  , fhasGender = False
  , ftactic = TFollow
  , fentryLevel = -2
  , finitialActors = 5  -- many initial, because never spawned
  , fleaderMode = LeaderAI $ AutoLeader True False
  , fhasUI = False
  }

playerSpawn = Player
  { fname = "Spawns of Warp"
  , fgroup = "spawn"
  , fskillsOther = zeroSkills
  , fcanEscape = False
  , fneverEmpty = False
  , fhiCondPoly = hiDweller
  , fhasNumbers = False
  , fhasGender = False
  , ftactic = TRoam
  , fentryLevel = -2
  , finitialActors = 2
  , fleaderMode = LeaderNull
  , fhasUI = False
  }

-- | A special player, for summoned actors that don't belong to any
-- of the main players of a given game. E.g., animals summoned during
-- a skirmish game between two hero factions land in the horror faction.
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
  , ftactic = TPatrol  -- disoriented
  , fentryLevel = -3
  , finitialActors = 0
  , fleaderMode = LeaderNull
  , fhasUI = False
  }

victoryOutcomes :: [Outcome]
victoryOutcomes = [Conquer, Escape]

hiHero, hiDweller, hiRaid :: HiCondPoly

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

hiRaid = [ ( [(HiLoot, 1)]
           , [minBound..maxBound] )
         , ( [(HiConst, 100)]
           , victoryOutcomes )
         ]

minusTen, meleeAdjacent, _meleeAndRanged :: Skills

-- To make sure only a lot of weak items can override move-only-leader, etc.
minusTen = EM.fromList $ zip [minBound..maxBound] [-10, -10..]

meleeAdjacent = EM.delete AbWait $ EM.delete AbMelee minusTen

-- Melee and reaction fire.
_meleeAndRanged = EM.delete AbProject meleeAdjacent
