-- | The type of kinds of game factions (heroes, enemies, NPCs, etc.)
-- for LambdaHack.
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
      [hero, monster, horror]
  }
hero,        monster, horror :: FactionKind

hero = FactionKind
  { fsymbol        = '@'
  , fname          = "hero"
  , ffreq          = [("hero", 1)]
  , fSkillsLeader = allSkills
  , fSkillsOther  = meleeAdjacent
  }

monster = FactionKind
  { fsymbol        = 'm'
  , fname          = "monster"
  , ffreq          = [("monster", 1), ("summon", 50)]
  , fSkillsLeader = allSkills
  , fSkillsOther  = allSkills
  }

horror = FactionKind
  { fsymbol        = 'h'
  , fname          = "horror"
  , ffreq          = [("horror", 1), ("summon", 50)]
  , fSkillsLeader = allSkills
  , fSkillsOther  = allSkills
  }

meleeAdjacent, _meleeAndRanged, allSkills :: Skills

meleeAdjacent = EM.fromList $ zip [AbWait, AbMelee] [1, 1..]

-- Melee and reaction fire.
_meleeAndRanged = EM.fromList $ zip [AbWait, AbMelee, AbProject] [1, 1..]

allSkills = unitSkills
