-- | The type of kinds of game modes for Space Privateers.
module Content.ModeKind ( cdefs ) where

import qualified Data.IntMap.Strict as IM

import Content.ModeKindPlayer
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

cavesCampaign :: Caves

cavesCampaign = IM.fromList $ [ (-1, ("caveRogue", Just True))
                              , (-2, ("caveRogue", Nothing))
                              , (-3, ("caveRogue", Nothing)) ]
                              ++ zip [-4, -5..(-9)] (repeat ("dng", Nothing))
                              ++ [(-10, ("caveRogue", Nothing))]

