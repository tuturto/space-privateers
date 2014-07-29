-- | Cave layouts for Space Privateers
module Content.CaveKind ( cdefs ) where

import Data.Ratio

import Game.LambdaHack.Common.ContentDef
import Game.LambdaHack.Common.Dice
import Game.LambdaHack.Common.Misc
import Game.LambdaHack.Content.CaveKind

cdefs :: ContentDef CaveKind
cdefs = ContentDef
  { getSymbol = csymbol
  , getName = cname
  , getFreq = cfreq
  , validate = validateCaveKind
  , content =
      [rogue, arena, empty, noise]
  }
rogue,        arena, empty, noise :: CaveKind

rogue = CaveKind
  { csymbol       = '$'
  , cname         = "General quarters"
  , cfreq         = [("dng", 100), ("caveRogue", 1)]
  , cxsize        = fst normalLevelBound + 1
  , cysize        = snd normalLevelBound + 1
  , cgrid         = DiceXY (3 * d 2) (d 2 + 2)
  , cminPlaceSize = DiceXY (2 * d 2 + 2) 4
  , cmaxPlaceSize = DiceXY 15 10
  , cdarkChance   = d 54 + d 20
  , cnightChance  = 51
  , cauxConnects  = 1%3
  , cmaxVoid      = 1%6
  , cminStairDist = 30
  , cdoorChance   = 1%2
  , copenChance   = 1%10
  , chidden       = 8
  , cactorFreq    = [("monster", 50), ("horror", 25)]
  , citemNum      = 7 * d 2
  , citemFreq     = [("useful", 70), ("treasure", 30)]
  , cplaceFreq    = [("rogue", 100)]
  , cpassable     = False
  , cdefTile        = "fillerWall"
  , cdarkCorTile    = "floorCorridorDark"
  , clitCorTile     = "floorCorridorLit"
  , cfillerTile     = "fillerWall"
  , couterFenceTile = "basic outer fence"
  , clegendDarkTile = "legendDark"
  , clegendLitTile  = "legendLit"
  }
arena = rogue
  { csymbol       = 'A'
  , cname         = "A service deck"
  , cfreq         = [("dng", 30), ("caveArena", 1)]
  , cgrid         = DiceXY (2 * d 2) (2 * d 2)
  , cminPlaceSize = DiceXY (2 * d 2 + 3) 4
  , cdarkChance   = d 80 + d 60
  , cnightChance  = 0
  , cmaxVoid      = 1%3
  , chidden       = 1000
  , citemNum      = 5 * d 2  -- few rooms
  , cdefTile      = "arenaSet"
  , cdarkCorTile  = "trailLit"  -- let paths around rooms be lit
  , clitCorTile   = "trailLit"
  }
empty = rogue
  { csymbol       = '.'
  , cname         = "a storage deck"
  , cfreq         = [("dng", 20), ("caveEmpty", 1)]
  , cgrid         = DiceXY (d 2 + 1) 1
  , cminPlaceSize = DiceXY (d 5 + 5) (d 5 + 5)
  , cdarkChance   = d 80 + d 80
  , cnightChance  = 0
  , cauxConnects  = 1
  , cmaxVoid      = 1%2
  , cminStairDist = 50
  , chidden       = 1000
  , citemNum      = d 8 + 2  -- whole floor strewn with treasure
  , cdefTile      = "emptySet"
  , cdarkCorTile  = "trailLit"  -- let paths around rooms be lit
  , clitCorTile   = "floorArenaLit"
  }
noise = rogue
  { csymbol       = '!'
  , cname         = "Mech Bay"
  , cfreq         = [("dng", 20), ("caveNoise", 1)]
  , cgrid         = DiceXY (2 * d 2 + 2) 1
  , cminPlaceSize = DiceXY (3 * d 2 + 2) 5
  , cdarkChance   = d 80 + d 40
  , cnightChance  = d 40 + d 40
  , cmaxVoid      = 0
  , chidden       = 1000
  , citemNum      = d 4 + 2  -- fewer rooms
  , cdefTile      = "noiseSet"
  , cdarkCorTile  = "trailLit"  -- let trails give off light
  , clitCorTile   = "trailLit"
  }
