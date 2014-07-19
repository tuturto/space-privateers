-- | Monsters and heroes for Space Privateers
module Content.ActorKind ( cdefs ) where

import Game.LambdaHack.Common.Ability
import Game.LambdaHack.Common.Color
import Game.LambdaHack.Common.ContentDef
import Game.LambdaHack.Common.Random
import Game.LambdaHack.Common.Time
import Game.LambdaHack.Content.ActorKind

cdefs :: ContentDef ActorKind
cdefs = ContentDef
  { getSymbol = asymbol
  , getName = aname
  , getFreq = afreq
  , validate = validateActorKind
  , content =
      [hero, projectile, shambler, greaterShambler, quine]
  }
hero,        projectile, shambler, greaterShambler, quine :: ActorKind

hero = ActorKind
  { asymbol = '@'
  , aname   = "hero"
  , afreq   = [("hero", 1)]
  , acolor  = BrWhite  -- modified if many hero factions
  , ahp     = rollDice 50 1
  , aspeed  = toSpeed 2
  , asight  = True
  , asmell  = False
  , aiq     = 15  -- higher that that leads to looping movement
  , aregen  = 500
  , acanDo  = [minBound..maxBound]
  }

projectile = ActorKind  -- includes homing missiles
  { asymbol = '*'
  , aname   = "projectile"
  , afreq   = [("projectile", 1)]  -- Does not appear randomly in the dungeon.
  , acolor  = BrWhite
  , ahp     = rollDice 0 0
  , aspeed  = toSpeed 0
  , asight  = False
  , asmell  = False
  , aiq     = 0
  , aregen  = maxBound
  , acanDo  = [Track]
  }

shambler = ActorKind
  { asymbol = 'w'
  , aname   = "warp shambler"
  , afreq   = [("monster", 60), ("horror", 60)]
  , acolor  = BrRed
  , ahp     = rollDice 7 4
  , aspeed  = toSpeed 2
  , asight  = True
  , asmell  = False
  , aiq     = 8
  , aregen  = 100
  , acanDo  = [minBound..maxBound]
  }
greaterShambler = ActorKind
  { asymbol = 'w'
  , aname   = "greater warp shambler"
  , afreq   = [("monster", 15), ("horror", 15)]
  , acolor  = BrBlue
  , ahp     = rollDice 1 6
  , aspeed  = toSpeed 4
  , asight  = True
  , asmell  = False
  , aiq     = 12
  , aregen  = 10  -- Regenerates fast (at max HP most of the time!).
  , acanDo  = [minBound..maxBound]
  }
quine = ActorKind
  { asymbol = 'q'
  , aname   = "quine"
  , afreq   = [("monster", 20), ("horror", 20)]
  , acolor  = Green
  , ahp     = rollDice 17 2
  , aspeed  = toSpeed 1.8
  , asight  = False
  , asmell  = True
  , aiq     = 0
  , aregen  = 100
  , acanDo  = [minBound..maxBound]
  }
