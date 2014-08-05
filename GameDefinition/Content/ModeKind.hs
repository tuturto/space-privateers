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
  { msymbol  = 'a'
  , mname    = "campaign"
  , mfreq    = [("campaign", 1)]
  , mplayers = playersCampaign
  , mcaves   = cavesCampaign
  , mdesc    = "Get ready to assault the city vessel and plunder some loot!"
  }

playersCampaign :: Players

playersCampaign = Players
  { playersList = [ playerHero
                  , playerMerchant
                  , playerChaos
                  , playerHorror
                  , playerSpawn ]
  , playersEnemy = [ ("Space Privateers", "Merchant Mariners")
                   , ("Space Privateers", "Forces of Chaos") 
                   , ("Space Privateers", "Spawns of Warp")
                   , ("Merchant Mariners", "Forces of Chaos") 
                   , ("Merchant Mariners", "Spawns of Warp") ]
  , playersAlly = [("Forces of Chaos", "Spawns of Warp")] }

playerHero, playerMerchant, playerChaos, playerSpawn, playerHorror :: Player

playerHero = Player
  { playerName = "Space Privateers"
  , playerFaction = "hero"
  , playerIsSpawn = False
  , playerIsHero = True
  , playerEntry = -1
  , playerInitial = 3
  , playerLeader = True
  , playerAI = False
  , playerUI = True
  }

playerMerchant = Player
  { playerName = "Merchant Mariners"
  , playerFaction = "merchant"
  , playerIsSpawn = True
  , playerIsHero = False
  , playerEntry = -1
  , playerInitial = 3
  , playerLeader = False
  , playerAI = True
  , playerUI = False
  }

playerChaos = Player
  { playerName = "Forces of Chaos"
  , playerFaction = "chaos"
  , playerIsSpawn = True
  , playerIsHero = False
  , playerEntry = -1
  , playerInitial = 5
  , playerLeader = False
  , playerAI = True
  , playerUI = False
  }

playerHorror = Player
  { playerName = "Horrors of Warp"
  , playerFaction = "horror"
  , playerIsSpawn = True
  , playerIsHero = False
  , playerEntry = -1
  , playerInitial = 0
  , playerLeader = False
  , playerAI = True
  , playerUI = False
  }

playerSpawn = Player
  { playerName = "Spawns of Warp"
  , playerFaction = "spawn"
  , playerIsSpawn = True
  , playerIsHero = False
  , playerEntry = -1
  , playerInitial = 0
  , playerLeader = False
  , playerAI = True
  , playerUI = False
  }

cavesCampaign :: Caves

cavesCampaign = IM.fromList $ [ (-1, ("caveRogue", Just True))
                              , (-2, ("caveRogue", Nothing))
                              , (-3, ("caveRogue", Nothing)) ]
                              ++ zip [-4, -5..(-9)] (repeat ("dng", Nothing))
                              ++ [(-10, ("caveRogue", Nothing))]

