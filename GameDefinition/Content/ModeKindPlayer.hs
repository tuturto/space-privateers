-- | Basic players definitions.
module Content.ModeKindPlayer
  ( playerHero, playerMerchant, playerChaos, playerTechCult, playerHorror, playerSpawn
  ) where

import qualified Data.EnumMap.Strict as EM

import Game.LambdaHack.Common.Ability
import Game.LambdaHack.Content.ModeKind

playerHero, playerMerchant, playerChaos, playerHorror, playerTechCult, playerSpawn :: Player

playerHero = Player
  { fname = "Space Privateers"
  , fgroup = "hero"
  , fskillsOther = meleeAdjacent
  , fcanEscape = True
  , fneverEmpty = True
  , fhasNumbers = True
  , fhasGender = True
  , ftactic = TExplore
  , fentryLevel = -1
  , finitialActors = 3
  , fleaderMode = LeaderUI $ AutoLeader False False
  , fhasUI = True
  }

playerMerchant = Player
  { fname = "Merchant Mariners"
  , fgroup = "merchant"
  , fskillsOther = _meleeAndRanged
  , fcanEscape = False
  , fneverEmpty = True
  , fhasNumbers = False
  , fhasGender = True
  , ftactic = TPatrol
  , fentryLevel = -1
  , finitialActors = 3
  , fleaderMode = LeaderAI $ AutoLeader True True
  , fhasUI = False
  }

playerChaos = Player
  { fname = "Forces of Chaos"
  , fgroup = "chaos"
  , fskillsOther = _meleeAndRanged
  , fcanEscape = False
  , fneverEmpty = True
  , fhasNumbers = False
  , fhasGender = True
  , ftactic = TExplore
  , fentryLevel = -1
  , finitialActors = 3
  , fleaderMode = LeaderAI $ AutoLeader True True
  , fhasUI = False
  }

playerSpawn = Player
  { fname = "Spawns of Warp"
  , fgroup = "spawn"
  , fskillsOther = animalSkills
  , fcanEscape = False
  , fneverEmpty = False
  , fhasNumbers = False
  , fhasGender = False
  , ftactic = TRoam
  , fentryLevel = -2
  , finitialActors = 3
  , fleaderMode = LeaderAI $ AutoLeader True True
  , fhasUI = False
  }

playerTechCult = Player
  { fname = "Tech Cult"
  , fgroup = "tech"
  , fskillsOther = _meleeAndRanged
  , fcanEscape = True
  , fneverEmpty = True
  , fhasNumbers = False
  , fhasGender = False
  , ftactic = TFollow
  , fentryLevel = -1
  , finitialActors = 4
  , fleaderMode = LeaderAI $ AutoLeader False False
  , fhasUI = False
  }

-- | A special player, for summoned actors that don't belong to any
-- of the main players of a given game. E.g., animals summoned during
-- a duel game between two hero players land in the horror faction.
-- In every game, either all factions for which summoning items exist
-- should be present or a horror player should be added to host them.
-- Actors that can be summoned should have "horror" in their @ifreq@ set.
playerHorror = Player
  { fname = "Horrors of Warp"
  , fgroup = "horror"
  , fskillsOther = unitSkills
  , fcanEscape = False
  , fneverEmpty = False
  , fhasNumbers = False
  , fhasGender = False
  , ftactic = TPatrol
  , fentryLevel = -3
  , finitialActors = 0
  , fleaderMode = LeaderNull
  , fhasUI = False
  }

meleeAdjacent, _meleeAndRanged, animalSkills :: Skills

meleeAdjacent = EM.fromList $ zip [AbWait, AbMelee] [1, 1..]

-- Melee and reaction fire.
_meleeAndRanged = EM.fromList $ zip [AbWait, AbMelee, AbProject] [1, 1..]

animalSkills =
  EM.fromList $ zip [AbMove, AbMelee, AbAlter, AbWait, AbTrigger] [1, 1..]
