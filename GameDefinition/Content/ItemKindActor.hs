-- | Actor (or rather actor body trunk) definitions.
module Content.ItemKindActor ( actors ) where

import qualified Data.EnumMap.Strict as EM

import Game.LambdaHack.Common.Ability
import Game.LambdaHack.Common.Color
import Game.LambdaHack.Common.Effect
import Game.LambdaHack.Common.Flavour
import Game.LambdaHack.Common.Misc
import Game.LambdaHack.Content.ItemKind

actors :: [ItemKind]
actors = privateers ++ merchants ++ forcesOfChaos ++ spawns ++ animals

privateers, merchants, forcesOfChaos, spawns, animals :: [ItemKind]

privateers    = [warrior, scout]
merchants     = [merchant, merchantSgt]
forcesOfChaos = [chaosWarrior, chaosLord]
spawns        = [warpBeast]
animals       = [ventLizard]

warrior, scout :: ItemKind
merchant, merchantSgt :: ItemKind
chaosWarrior, chaosLord :: ItemKind
warpBeast :: ItemKind
ventLizard :: ItemKind

-- * Heroes (hero)

warrior = ItemKind
  { isymbol  = '@'
  , iname    = "warrior"
  , ifreq    = [("hero", 100)]
  , iflavour = zipPlain [BrBlack]
  , icount   = 1
  , irarity  = [(1, 5)]
  , iverbHit = "thud"
  , iweight  = 80000
  , iaspects = [ AddMaxHP 50, AddMaxCalm 60, AddSpeed 20
               , AddSight 3 ]
  , ieffects = []
  , ifeature = [Durable, Identified]
  , idesc    = "PBI, ready to take the next city vessel."
  , ikit     = [("fist", COrgan), ("foot", COrgan), ("eye 4", COrgan),
                ("starting weapon", CEqp)]
  }

scout = warrior
  { iname    = "scout"
  , iaspects = [ AddMaxHP 40, AddMaxCalm 60, AddSpeed 25
               , AddSight 4 ]
  , idesc    = "Fast and keen scouts are essential any fighting force."
  , ikit     = [("fist", COrgan), ("foot", COrgan), ("eye 5", COrgan),
                ("any arrow", CInv), ("any vial", CInv), ("any vial", CInv)]
  }

-- * Merchant Mariners (merchant)

merchant = ItemKind
  { isymbol  = '@'
  , iname    = "merchant mariner"
  , ifreq    = [("merchant", 100)]
  , iflavour = zipPlain [Blue]
  , icount   = 1
  , irarity  = [(1, 10)]
  , iverbHit = "thud"
  , iweight  = 80000
  , iaspects = [ AddMaxHP 30, AddMaxCalm 40, AddSpeed 20
               , AddSight 3 ]
  , ieffects = []
  , ifeature = [Durable, Identified]
  , idesc    = "Merchant mariners are operating city vessels on their endless journey to stars."
  , ikit     = [("fist", COrgan), ("foot", COrgan), ("eye 4", COrgan)]
  }

merchantSgt = merchant
  { iname    = "merchant mariner sgt"
  , ifreq    = [("merchant", 100)]
  , iflavour = zipPlain [BrBlue]
  , icount   = 1
  , irarity  = [(1, 1), (10, 3)]
  , iverbHit = "thud"
  , iweight  = 80000
  , iaspects = [ AddMaxHP 40, AddMaxCalm 60, AddSpeed 20
               , AddSight 3 ]
  , ieffects = []
  , ifeature = [Durable, Identified]
  , idesc    = "Squad leader for merchant mariners"
  , ikit     = [("fist", COrgan), ("foot", COrgan), ("eye 4", COrgan),
                ("starting weapon", CEqp)]
  }

-- * Forces of Chaos (chaos)

chaosWarrior = ItemKind
  { isymbol  = 'c'
  , iname    = "chaos warrior"
  , ifreq    = [("chaos", 100)]
  , iflavour = zipPlain [BrBlack]
  , icount   = 1
  , irarity  = [(1, 5)]
  , iverbHit = "thud"
  , iweight  = 100000
  , iaspects = [ AddMaxHP 40, AddMaxCalm 70, AddSpeed 20
               , AddSight 3 ]
  , ieffects = []
  , ifeature = [Durable, Identified]
  , idesc    = "Warrior of Chaos, ready to wreck havoc."
  , ikit     = [("fist", COrgan), ("foot", COrgan), ("eye 4", COrgan),
                ("starting weapon", CEqp)]
  }

chaosLord    = chaosWarrior
  { isymbol  = 'c'
  , iname    = "chaos lord"
  , ifreq    = [("chaos", 100)]
  , irarity  = [(5, 1), (10, 3)]
  , iflavour = zipPlain [BrRed]
  , iaspects = [ AddMaxHP 60, AddMaxCalm 70, AddSpeed 20
               , AddSight 3 ]
  , idesc    = "Lord of Chaos, leader of warriors"
  }

-- * Horrors (spawn)

warpBeast    = ItemKind
  { isymbol  = 'w'
  , iname    = "warp beast"
  , ifreq    = [("spawn", 100)]
  , iflavour = zipPlain [BrRed]
  , icount   = 1
  , irarity  = [(1, 5)]
  , iverbHit = "thud"
  , iweight  = 40000
  , iaspects = [ AddMaxHP 20, AddMaxCalm 30, AddSpeed 20
               , AddSight 1 ]
  , ieffects = []
  , ifeature = [Durable, Identified]
  , idesc    = "Shambling beast of warp has phased into this corporeal realm."
  , ikit     = [("small claw", COrgan), ("foot", COrgan), ("eye 2", COrgan),
                ("nostril", COrgan)]
  }

-- * Animals

ventLizard = ItemKind
  { isymbol  = ':'
  , iname    = "vent lizard"
  , ifreq    = [("summonable animal", 100)]
  , iflavour = zipPlain [Green]
  , icount   = 1
  , irarity  = [(1, 5)]
  , iverbHit = "thud"
  , iweight  = 25000
  , iaspects = [ AddMaxHP 15, AddMaxCalm 30, AddSpeed 18
               , AddSkills $ EM.singleton AbAlter (-1)
               , AddSight 3 ]
  , ieffects = []
  , ifeature = [Durable, Identified]
  , idesc    = ""
  , ikit     = [ ("claw", COrgan), ("snout", COrgan), ("armored skin", COrgan)
               , ("nostril", COrgan) ]
  }
