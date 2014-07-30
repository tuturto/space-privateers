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
      [rogue, arena, empty, noise, battle, skirmish, ambush, safari1, safari2, safari3]
  }
rogue,        arena, empty, noise, battle, skirmish, ambush, safari1, safari2, safari3 :: CaveKind

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
arena = rogue
  { csymbol       = 'A'
  , cname         = "Maintenance deck"
  , cfreq         = [("dng", 30), ("caveArena", 1)]
  , cgrid         = DiceXY (2 * d 2) (2 * d 2)
  , cminPlaceSize = DiceXY (2 * d 2 + 3) 4
  , cdarkChance   = d 80 + dl 60
  , cnightChance  = 0
  , cmaxVoid      = 1%3
  , chidden       = 1000
  , cactorFreq    = [("merchant", 70), ("chaos", 25), ("horror", 5)]
  , citemNum      = 8 * d 2
  , cpassable     = True
  , cdefTile      = "arenaSet"
  , cdarkCorTile  = "trailLit"
  , clitCorTile   = "trailLit"
  }
empty = rogue
  { csymbol       = 'E'
  , cname         = "Storage level"
  , cfreq         = [("dng", 20), ("caveEmpty", 1)]
  , cgrid         = DiceXY (d 2 + 1) 1
  , cminPlaceSize = DiceXY 10 10
  , cmaxPlaceSize = DiceXY 24 12
  , cdarkChance   = d 80 + dl 80
  , cnightChance  = 0
  , cauxConnects  = 1
  , cmaxVoid      = 1%2
  , cminStairDist = 50
  , chidden       = 1000
  , cactorFreq    = [("merchant", 50), ("chaos", 25), ("horror", 25)]
  , citemNum      = 6 * d 2
  , cpassable     = True
  , cdefTile      = "emptySet"
  , cdarkCorTile  = "floorArenaDark"
  , clitCorTile   = "floorArenaLit"
  }
noise = rogue
  { csymbol       = 'N'
  , cname         = "Engineering deck"
  , cfreq         = [("dng", 10), ("caveNoise", 1)]
  , cgrid         = DiceXY 3 3
  , cminPlaceSize = DiceXY 8 4
  , cmaxPlaceSize = DiceXY 24 12
  , cnightChance  = d 100
  , cauxConnects  = 0
  , cmaxVoid      = 0
  , chidden       = 1000
  , cactorFreq    = [("merchant", 70), ("chaos", 25), ("horror", 5)]
  , citemNum      = 12 * d 2
  , cpassable     = True
  , cplaceFreq    = [("noise", 50), ("rogue", 50)]
  , cdefTile      = "noiseSet"
  , cdarkCorTile  = "floorArenaDark"
  , clitCorTile   = "floorArenaLit"
  }
battle = rogue
  { csymbol       = 'B'
  , cname         = "Old battle ground"
  , cfreq         = [("caveBattle", 1)]
  , cgrid         = DiceXY (2 * d 2 + 1) 3
  , cminPlaceSize = DiceXY 3 3
  , cmaxPlaceSize = DiceXY 9 7
  , cdarkChance   = 0
  , cnightChance  = 100
  , cdoorChance   = 2%10
  , copenChance   = 9%10
  , chidden       = 1000
  , cactorFreq    = []
  , citemNum      = 12 * d 2
  , citemFreq     = [("useful", 100)]
  , cplaceFreq    = [("battle", 50), ("rogue", 50)]
  , cpassable     = True
  , cdefTile      = "battleSet"
  , cdarkCorTile  = "trailLit"  -- let trails give off light
  , clitCorTile   = "trailLit"
  }
skirmish = rogue  -- many random solid tiles, to break LOS, since it's a day
  { csymbol       = 'S'
  , cname         = "Sunny woodland"
  , cfreq         = [("caveSkirmish", 1)]
  , cgrid         = DiceXY (2 * d 2 + 2) (d 2 + 2)
  , cminPlaceSize = DiceXY 3 3
  , cmaxPlaceSize = DiceXY 7 5
  , cdarkChance   = 100
  , cnightChance  = 0
  , cdoorChance   = 1
  , copenChance   = 0
  , chidden       = 1000
  , cactorFreq    = []
  , citemNum      = 12 * d 2
  , citemFreq     = [("useful", 100)]
  , cplaceFreq    = [("skirmish", 60), ("rogue", 40)]
  , cpassable     = True
  , cdefTile      = "skirmishSet"
  , cdarkCorTile  = "floorArenaLit"
  , clitCorTile   = "floorArenaLit"
  }
ambush = rogue  -- lots of lights, to give a chance to snipe
  { csymbol       = 'M'
  , cname         = "Warp Drive"
  , cfreq         = [("dng", 10), ("caveAmbush", 1)]
  , cgrid         = DiceXY (2 * d 2 + 3) (d 2 + 2)
  , cminPlaceSize = DiceXY 3 3
  , cmaxPlaceSize = DiceXY 5 5
  , cdarkChance   = 0
  , cnightChance  = 100
  , cauxConnects  = 1
  , cdoorChance   = 1%10
  , copenChance   = 9%10
  , chidden       = 1000
  , cactorFreq    = [("merchant", 10), ("chaos", 25), ("horror", 65)]
  , citemNum      = 12 * d 2
  , citemFreq     = [("useful", 100)]
  , cplaceFreq    = [("ambush", 100)]
  , cpassable     = True
  , cdefTile      = "ambushSet"
  , cdarkCorTile  = "trailLit"  -- let trails give off light
  , clitCorTile   = "trailLit"
  }
safari1 = ambush {cfreq = [("caveSafari1", 1)]}
safari2 = battle {cfreq = [("caveSafari2", 1)]}
safari3 = skirmish {cfreq = [("caveSafari3", 1)]}
