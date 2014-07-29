-- | The type of kinds of game modes for LambdaHack.
module Content.ModeKind ( cdefs ) where

import qualified Data.IntMap.Strict as IM

import Game.LambdaHack.Common.ContentDef
import Game.LambdaHack.Content.ModeKind

cdefs :: ContentDef ModeKind
cdefs = ContentDef
  { getSymbol = msymbol
  , getName = mname
  , getFreq = mfreq
  , validate = validateModeKind
  , content =
      [campaign]
  }
campaign :: ModeKind

campaign = ModeKind
  { msymbol  = 'r'
  , mname    = "campaign"
  , mfreq    = [("campaign", 1)]
  , mplayers = playersCampaign
  , mcaves   = cavesCampaign
  , mdesc    = "single player campaign"
  }

playersCampaign  :: Players

playersCampaign = Players
  { playersList = [ playerHero {playerInitial = 3}
                  , playerMonster
                  , playerHorror ]
  , playersEnemy = [("Adventurer Party", "Monster Hive")]
  , playersAlly = [] }

playerHero, playerMonster, playerHorror :: Player

playerHero = Player
  { playerName = "Adventurer Party"
  , playerFaction = "hero"
  , playerIsSpawn = False
  , playerIsHero = True
  , playerEntry = -1
  , playerInitial = 3
  , playerLeader = True
  , playerAI = False
  , playerUI = True
  }

playerMonster = Player
  { playerName = "Monster Hive"
  , playerFaction = "monster"
  , playerIsSpawn = True
  , playerIsHero = False
  , playerEntry = -3
  , playerInitial = 5
  , playerLeader = True
  , playerAI = True
  , playerUI = False
  }

playerHorror = Player
  { playerName = "Horror Den"
  , playerFaction = "horror"
  , playerIsSpawn = False
  , playerIsHero = False
  , playerEntry = -1
  , playerInitial = 0
  , playerLeader = False
  , playerAI = True
  , playerUI = False
  }


cavesCampaign :: Caves

cavesCampaign = IM.fromList [ (-1, ("caveRogue", Just True))
                            , (-2, ("caveRogue", Nothing))
                            , (-3, ("caveEmpty", Nothing))
                            , (-10, ("caveNoise", Nothing))]
