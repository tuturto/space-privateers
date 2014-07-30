-- | The type of kinds of game factions (heroes, enemies, NPCs, etc.)
-- for Space Privateers.
module Content.FactionKind ( cdefs ) where

import qualified Data.EnumMap.Strict as EM

import Game.LambdaHack.Common.Ability
import Game.LambdaHack.Common.ContentDef
import Game.LambdaHack.Content.FactionKind

cdefs :: ContentDef FactionKind
cdefs = ContentDef
  { getSymbol = fsymbol
  , getName = fname
  , getFreq = ffreq
  , validate = validateFactionKind
  , content =
      [hero, merchant, chaos, horror]
  }
hero,        merchant, chaos, horror :: FactionKind

hero = FactionKind
  { fsymbol       = '1'
  , fname         = "hero"
  , ffreq         = [("hero", 1)]
  , fSkillsLeader = allSkills
  , fSkillsOther  = meleeAdjacent
  }

merchant = FactionKind
  { fsymbol       = '@'
  , fname         = "merchant"
  , ffreq         = [("merchant", 1)]
  , fSkillsLeader = allSkills
  , fSkillsOther  = allSkills
  }

chaos = FactionKind
  { fsymbol       = 'c'
  , fname         = "chaos"
  , ffreq         = [("chaos", 1)]
  , fSkillsLeader = allSkills
  , fSkillsOther  = allSkills
  }

horror = FactionKind
  { fsymbol       = 'h'
  , fname         = "horror"
  , ffreq         = [("horror", 1)]
  , fSkillsLeader = allSkills
  , fSkillsOther  = allSkills
  }


meleeAdjacent, _meleeAndRanged, animalSkills, allSkills :: Skills

meleeAdjacent = EM.fromList $ zip [AbWait, AbMelee] [1, 1..]

-- Melee and reaction fire.
_meleeAndRanged = EM.fromList $ zip [AbWait, AbMelee, AbProject] [1, 1..]

animalSkills =
  EM.fromList $ zip [AbMove, AbMelee, AbAlter, AbWait, AbTrigger] [1, 1..]

allSkills = unitSkills
