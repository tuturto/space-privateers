-- | Cave layouts.
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
  , validateSingle = validateSingleCaveKind
  , validateAll = validateAllCaveKind
  , content =
      [rogue, munitorium, temple, rogueLit]
  }
rogue,        munitorium, temple, rogueLit :: CaveKind

rogue = CaveKind
  { csymbol         = 'R'
  , cname           = "General quarters"
  , cfreq           = [("campaign random", 100), ("caveRogue", 1)]
  , cxsize          = fst normalLevelBound + 1
  , cysize          = snd normalLevelBound + 1
  , cgrid           = DiceXY (3 * d 2) (d 2 + 2)
  , cminPlaceSize   = DiceXY (2 * d 2 + 2) 4
  , cmaxPlaceSize   = DiceXY 15 10
  , cdarkChance     = d 54 + dl 20
  , cnightChance    = 51  -- always night
  , cauxConnects    = 1%3
  , cmaxVoid        = 1%6
  , cminStairDist   = 30
  , cdoorChance     = 1%2
  , copenChance     = 1%10
  , chidden         = 8
  , cactorCoeff     = 130  -- the maze requires time to explore
  , cactorFreq      = [("merchant", 50), ("chaos", 45), ("spawn", 5)]
  , citemNum        = 10 * d 2
  , citemFreq       = [("useful", 70), ("treasure", 30)]
  , cplaceFreq      = [("rogue", 100)]
  , cpassable       = False
  , cdefTile        = "fillerWall"
  , cdarkCorTile    = "floorCorridorDark"
  , clitCorTile     = "floorCorridorLit"
  , cfillerTile     = "fillerWall"
  , couterFenceTile = "basic outer fence"
  , clegendDarkTile = "legendDark"
  , clegendLitTile  = "legendLit"
  }
munitorium = rogue
  { csymbol         = 'M'
  , cname           = "Munitorium"
  , cfreq           = [("campaign random", 15), ("munitorium", 1)]
  , cgrid           = DiceXY 3 3
  , cminPlaceSize   = DiceXY 15 4
  , cmaxPlaceSize   = DiceXY 25 10
  , cdarkChance     = d 55
  , cnightChance    = d 70
  , cactorFreq      = [("merchant", 80), ("chaos", 5), ("spawn", 15)]
  , citemNum        = 8 * d 2
  , citemFreq       = [("weapon", 70), ("armour", 20), ("useful", 10)]
  , cplaceFreq      = [("rogue", 100)]
  , cpassable       = True
  , cdefTile        = "arenaSet"
  , cdarkCorTile    = "floorArenaDark"
  , clitCorTile     = "floorArenaLit"
}
temple = rogue
  { csymbol         = 'T'
  , cname           = "Temple of Machinae"
  , cfreq           = [("temple", 1)]
  , cgrid           = DiceXY 3 3
  , cminPlaceSize   = DiceXY 15 4
  , cmaxPlaceSize   = DiceXY 25 10
  , cdarkChance     = d 55
  , cnightChance    = d 70
  , cactorFreq      = [("chaos", 50), ("spawn", 50)]
  , citemNum        = 8 * d 2
  , citemFreq       = [("weapon", 70), ("armour", 20), ("useful", 10)]
  , cplaceFreq      = [("rogue", 100)]
  , cpassable       = True
  , cdefTile        = "arenaSet"
  , cdarkCorTile    = "floorArenaDark"
  , clitCorTile     = "floorArenaLit"
}
rogueLit = rogue
  { csymbol       = 'S'
  , cfreq         = [("caveRogueLit", 1)]
  , cdarkChance   = 0
  , cmaxVoid      = 1%10
  , cactorCoeff   = 1000  -- deep level with no eqp, so slow spawning
  , citemNum      = 30 * d 2  -- just one level, hard enemies, treasure
  , citemFreq     = [("useful", 33), ("gem", 33), ("currency", 33)]
  }
