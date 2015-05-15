-- | Game mode definitions.
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
      [campaign, raid, skirmish, ambush, battle, battleSurvival, safari, safariSurvival, pvp, coop, defense, screensaver]
  }
campaign,        raid, skirmish, ambush, battle, battleSurvival, safari, safariSurvival, pvp, coop, defense, screensaver :: ModeKind

campaign = ModeKind
  { msymbol = 'c'
  , mname   = "campaign"
  , mfreq   = [("campaign", 1)]
  , mroster = rosterCampaign
  , mcaves  = cavesCampaign
  , mdesc   = "Get ready to assault the city vessel and plunder some loot!"
  }

raid = ModeKind
  { msymbol = 'r'
  , mname   = "raid"
  , mfreq   = [("raid", 1)]
  , mroster = rosterRaid
  , mcaves  = cavesRaid
  , mdesc   = ""  -- Tuturial game mode or just one for a quick casual game.
  }

skirmish = ModeKind
  { msymbol = 'k'
  , mname   = "skirmish"
  , mfreq   = [("skirmish", 1)]
  , mroster = rosterSkirmish
  , mcaves  = cavesSkirmish
  , mdesc   = "(This mode is intended solely for automated testing.)"
  }

ambush = ModeKind
  { msymbol = 'm'
  , mname   = "ambush"
  , mfreq   = [("ambush", 1)]
  , mroster = rosterAmbush
  , mcaves  = cavesAmbush
  , mdesc   = "(This mode is intended solely for automated testing.)"
  }

battle = ModeKind
  { msymbol = 'b'
  , mname   = "battle"
  , mfreq   = [("battle", 1)]
  , mroster = rosterBattle
  , mcaves  = cavesBattle
  , mdesc   = "(This mode is intended solely for automated testing.)"
  }

battleSurvival = ModeKind
  { msymbol = 'i'
  , mname   = "battle survival"
  , mfreq   = [("battle survival", 1)]
  , mroster = rosterBattleSurvival
  , mcaves  = cavesBattle
  , mdesc   = "(This mode is intended solely for automated testing.)"
  }

safari = ModeKind
  { msymbol = 'f'
  , mname   = "safari"
  , mfreq   = [("safari", 1)]
  , mroster = rosterSafari
  , mcaves  = cavesSafari
  , mdesc   = "(This mode is intended solely for automated testing.)"
  }

safariSurvival = ModeKind
  { msymbol = 'u'
  , mname   = "safari survival"
  , mfreq   = [("safari survival", 1)]
  , mroster = rosterSafariSurvival
  , mcaves  = cavesSafari
  , mdesc   = "(This mode is intended solely for automated testing.)"
  }

pvp = ModeKind
  { msymbol = 'v'
  , mname   = "PvP"
  , mfreq   = [("PvP", 1)]
  , mroster = rosterPvP
  , mcaves  = cavesSkirmish
  , mdesc   = "(This mode is intended solely for automated testing.)"
  }

coop = ModeKind
  { msymbol = 'o'
  , mname   = "Coop"
  , mfreq   = [("Coop", 1)]
  , mroster = rosterCoop
  , mcaves  = cavesCampaign
  , mdesc   = "(This mode is intended solely for automated testing.)"
  }

defense = ModeKind
  { msymbol = 'e'
  , mname   = "defense"
  , mfreq   = [("defense", 1)]
  , mroster = rosterDefense
  , mcaves  = cavesCampaign
  , mdesc   = "(This mode is intended solely for automated testing.)"
  }

screensaver = campaign
  { mname   = "campaign screensaver"
  , mfreq   = [("starting", 1)]
  , mroster = rosterCampaign
      { rosterList = (head (rosterList rosterCampaign))
                       -- changing leader by client needed, because of TFollow
                       {fleaderMode = LeaderAI $ AutoLeader True False}
                     : tail (rosterList rosterCampaign)
      }
  }

rosterCampaign, rosterRaid, rosterSkirmish, rosterAmbush, rosterBattle, rosterBattleSurvival, rosterSafari, rosterSafariSurvival, rosterPvP, rosterCoop, rosterDefense:: Roster

rosterCampaign = Roster
  { rosterList =  [ playerHero
                  , playerMerchant
                  , playerChaos
                  , playerTechCult
                  , playerHorror
                  , playerSpawn ]
  , rosterEnemy = [ ("Space Privateers", "Merchant Mariners")
                  , ("Space Privateers", "Forces of Chaos")
                  , ("Space Privateers", "Spawns of Warp")
                  , ("Merchant Mariners", "Forces of Chaos")
                  , ("Merchant Mariners", "Spawns of Warp")
                  , ("Tech Cult", "Forces of Chaos")
                  , ("Tech Cult", "Spawns of Warp")]
  , rosterAlly =  [ ("Forces of Chaos", "Spawns of Warp")
                  , ("Merchant Mariners", "Tech Cult")] }

rosterRaid = rosterCampaign
  { rosterList =  [ playerHero     { fhiCondPoly = hiRaid
                                   , fentryLevel = -4
                                   , finitialActors = 1 }
                  , playerMerchant { fentryLevel = -4
                                   , finitialActors = 1 }
                  , playerChaos    { fentryLevel = -4
                                   , finitialActors = 1 }
                  , playerTechCult { fentryLevel = -4
                                   , finitialActors = 1 }
                  , playerSpawn    { fentryLevel = -4
                                   , finitialActors = 1 } ] }

rosterSkirmish = Roster
  { rosterList = [ playerHero { fhiCondPoly = hiDweller
                              , fentryLevel = -3 }
                 , playerAntiHero { fname = "Pirates"
                                  , fhiCondPoly = hiDweller
                                  , fentryLevel = -3 }
                 , playerHorror ]
  , rosterEnemy = [ ("Space Privateers", "Pirates")
                  , ("Space Privateers", "Horrors of Warp")
                  , ("Pirates", "Horrors of Warp") ]
  , rosterAlly = [] }

rosterAmbush = Roster
  { rosterList = [ playerHero { fhiCondPoly = hiDweller
                              , fentryLevel = -5
                              , finitialActors = 4 }
                 , playerAntiHero { fname = "Pirates"
                                  , fhiCondPoly = hiDweller
                                  , fentryLevel = -5
                                  , finitialActors = 4 }
                 , playerHorror {fentryLevel = -5} ]
  , rosterEnemy = [ ("Space Privateers", "Pirates")
                  , ("Space Privateers", "Horrors of Warp")
                  , ("Pirates", "Horrors of Warp") ]
  , rosterAlly = [] }

rosterBattle = Roster
  { rosterList =  [ playerHero { fhiCondPoly = hiDweller
                               , fentryLevel = -5
                               , finitialActors = 5 }
                  , playerMerchant { fentryLevel = -5
                                   , finitialActors = 5
                                   , fneverEmpty = True }
                  , playerChaos    { fentryLevel = -5
                                   , finitialActors = 5
                                   , fneverEmpty = True }
                  , playerTechCult { fentryLevel = -5
                                   , finitialActors = 5
                                   , fneverEmpty = True }
                  , playerSpawn    { fentryLevel = -5
                                   , finitialActors = 5
                                   , fneverEmpty = True } ]
  , rosterEnemy = [ ("Space Privateers", "Merchant Mariners")
                  , ("Space Privateers", "Tech Cult")
                  , ("Space Privateers", "Forces of Chaos")
                  , ("Space Privateers", "Spawns of Warp") ]
  , rosterAlly =  [ ("Forces of Chaos", "Spawns of Warp")
                  , ("Merchant Mariners", "Tech Cult")] }

rosterBattleSurvival = rosterBattle  -- TODO

rosterSafari = rosterRaid  -- TODO

rosterSafariSurvival = rosterSafari  -- TODO

rosterPvP = rosterSkirmish  -- TODO, after multiplayer reimplemented

rosterCoop = rosterCampaign  -- TODO, after multiplayer reimplemented

rosterDefense = rosterCampaign
  { rosterList =  [ playerAntiHero
                  , playerAntiMerchant
                  , playerChaos
                  , playerTechCult
                  , playerHorror
                  , playerSpawn ] }

cavesCampaign, cavesRaid, cavesSkirmish, cavesAmbush, cavesBattle, cavesSafari :: Caves

cavesCampaign = IM.fromList $ [ (-1, ("caveRogue", Just True))
                              , (-2, ("temple", Nothing))
                              , (-3, ("caveRogue", Nothing)) ]
                              ++ zip [-4, -5..(-9)] (repeat ("campaign random", Nothing))
                              ++ [(-10, ("caveRogue", Nothing))]

cavesRaid = IM.fromList [(-4, ("caveRogueLit", Just True))]

cavesSkirmish = IM.fromList [(-3, ("munitorium", Nothing))]

cavesAmbush = IM.fromList [(-5, ("temple", Nothing))]

cavesBattle = IM.fromList [(-5, ("munitorium", Nothing))]

cavesSafari = IM.fromList [ (-4, ("caveRogue", Nothing))
                          , (-7, ("munitorium", Nothing))
                          , (-10, ("temple", Just False)) ]
