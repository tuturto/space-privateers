-- | Cave layouts for Space Privateers.
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
      [rogue, munitorium]
  }
rogue,        munitorium :: CaveKind

rogue = CaveKind
  { csymbol       = 'R'
  , cname         = "General quarters"
  , cfreq         = [("dng", 100), ("caveRogue", 1)]
  , cxsize        = fst normalLevelBound + 1
  , cysize        = snd normalLevelBound + 1
  , cgrid         = DiceXY (3 * d 2) (d 2 + 2)
  , cminPlaceSize = DiceXY (2 * d 2 + 2) 4
  , cmaxPlaceSize = DiceXY 15 10
  , cdarkChance   = d 54 + dl 20
  , cnightChance  = 51
  , cauxConnects  = 1%3
  , cmaxVoid      = 1%6
  , cminStairDist = 30
  , cdoorChance   = 1%2
  , copenChance   = 1%10
  , chidden       = 8
  , cactorFreq    = [("merchant", 50), ("chaos", 45), ("horror", 5)]
  , citemNum      = 10 * d 2
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
munitorium = rogue
  { csymbol         = 'M'
  , cname           = "Munitorium"
  , cfreq           = [("dng", 15), ("munitorium", 1)]
  , cgrid           = DiceXY 3 3
  , cminPlaceSize   = DiceXY 15 4
  , cmaxPlaceSize   = DiceXY 25 10
  , cdarkChance     = dl 5
  , cnightChance    = d 20
  , cactorFreq      = [("merchant", 80), ("chaos", 5), ("horror", 15)]
  , citemNum        = 8 * d 2
  , citemFreq       = [("weapon", 70), ("armour", 20), ("useful", 10)]
  , cplaceFreq      = [("rogue", 100)]
  , cpassable       = True
  , cdefTile        = "arenaSet"
  , cdarkCorTile    = "floorArenaDark"
  , clitCorTile     = "floorArenaLit"
}
