
-- | Monsters and heroes for Space Privateers
module Content.ActorKind ( actors ) where

import Game.LambdaHack.Common.Color
import Game.LambdaHack.Common.Effect
import Game.LambdaHack.Common.Flavour
import Game.LambdaHack.Common.Misc
import Game.LambdaHack.Content.ItemKind


actors :: [ItemKind]
actors = [hero, shambler, greaterShambler, quine]
hero,           shambler, greaterShambler, quine :: ItemKind

hero = ItemKind
  { isymbol   = '@'
  , iname     = "hero"
  , ifreq     = [("hero", 1)]
  , iflavour  = zipPlain [BrWhite]  -- modified if many hero factions
  , icount    = 1
  , irarity   = [(1, 5)]
  , iverbHit  = "thud"
  , iweight   = 80000
  , iaspects  = [ AddMaxHP 50, AddMaxCalm 60, AddSpeed 20, AddSight 3]
  , ieffects  = []
  , ifeature  = [ Durable, Identified ]
  , idesc     = ""
  , ikit      = [("fist", COrgan), ("foot", COrgan), ("eye 4", COrgan)]
  }

shambler = ItemKind
  { isymbol   = 'w'
  , iname     = "warp shambler"
  , ifreq     = [("monster", 60), ("horror", 60)]
  , iflavour  = zipPlain [BrRed]
  , icount    = 1
  , irarity   = [(1, 10), (10, 6)]
  , iverbHit  = "thud"
  , iweight   = 80000
  , iaspects  = [ AddMaxHP 15, AddMaxCalm 60, AddSpeed 20, AddSight 4]
  , ieffects  = []
  , ifeature  = [ Durable, Identified ]
  , idesc     = "Dimensional shambler shifting from plane of existence to another."
  , ikit      = [("tentacle", COrgan), ("foot", COrgan)]
  }

greaterShambler = shambler
  { isymbol   = 'w'
  , iname     = "greater warp shambler"
  , ifreq     = [("monster", 15), ("horror", 15)]
  , iflavour  = zipPlain [BrBlue]
  , irarity   = [(1, 10), (10, 6)]
  , iweight   = 70000
  , iaspects  = [ AddMaxHP 10, AddMaxCalm 60, AddSpeed 30, AddSight 4]
  }

quine = ItemKind
  { isymbol   = 'q'
  , iname     = "quine"
  , ifreq     = [("monster", 20), ("horror", 20)]
  , iflavour  = zipPlain [Green]
  , icount    = 1
  , irarity   = [(1, 10), (10, 6)]
  , iverbHit  = "thud"
  , iweight   = 80000
  , iaspects  = [ AddMaxHP 20, AddMaxCalm 60, AddSpeed 20, AddSight 4]
  , ieffects  = []
  , ifeature  = [ Durable, Identified ]
  , idesc     = "Small and puny warp beast that often lurks in air ducts and maintenance tunnels."
  , ikit      = [("fissure", COrgan), ("foot", COrgan)]
  }
