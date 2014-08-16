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
  , validateSingle = validateSingleModeKind
  , validateAll = validateAllModeKind
  , content =
      [campaign]
  }
campaign :: ModeKind

campaign = ModeKind
  { msymbol  = 'a'
  , mname    = "campaign"
  , mfreq    = [("campaign", 1)]
  , mroster  = rosterCampaign
  , mcaves   = cavesCampaign
  , mdesc    = "Get ready to assault the city vessel and plunder some loot!"
  }

rosterCampaign :: Roster

rosterCampaign = Roster
  { rosterList =  [ playerHero
                  , playerMerchant
                  , playerChaos
                  , playerHorror
                  , playerSpawn ]
  , rosterEnemy = [ ("Space Privateers", "Merchant Mariners")
                  , ("Space Privateers", "Forces of Chaos") 
                  , ("Space Privateers", "Spawns of Warp")
                  , ("Merchant Mariners", "Forces of Chaos") 
                  , ("Merchant Mariners", "Spawns of Warp") ]
  , rosterAlly =  [("Forces of Chaos", "Spawns of Warp")] }

cavesCampaign :: Caves

cavesCampaign = IM.fromList $ [ (-1, ("caveRogue", Just True))
                              , (-2, ("caveRogue", Nothing))
                              , (-3, ("caveRogue", Nothing)) ]
                              ++ zip [-4, -5..(-9)] (repeat ("campaign random", Nothing))
                              ++ [(-10, ("caveRogue", Nothing))]

