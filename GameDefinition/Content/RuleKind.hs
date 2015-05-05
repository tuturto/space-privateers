{-# LANGUAGE TemplateHaskell #-}
-- | Game rules and assorted game setup data for Space Privateer.
module Content.RuleKind ( cdefs ) where

import Language.Haskell.TH.Syntax
import System.FilePath

-- Cabal
import qualified Paths_SpacePrivateers as Self (getDataFileName, version)

import Game.LambdaHack.Common.ContentDef
import Game.LambdaHack.Common.Vector
import Game.LambdaHack.Content.RuleKind

cdefs :: ContentDef RuleKind
cdefs = ContentDef
  { getSymbol = rsymbol
  , getName = rname
  , getFreq = rfreq
  , validateSingle = validateSingleRuleKind
  , validateAll = validateAllRuleKind
  , content =
      [standard]
  }

standard :: RuleKind
standard = RuleKind
  { rsymbol        = 's'
  , rname          = "standard Space Privateers ruleset"
  , rfreq          = [("standard", 100)]
  , raccessible    = Nothing
  , raccessibleDoor =
      Just $ \spos tpos -> not $ isDiagonal $ spos `vectorToFrom` tpos
  , rtitle         = "Space Privateers"
  , rpathsDataFile = Self.getDataFileName
  , rpathsVersion  = Self.version
  , rcfgUIName = "config.ui"
  , rcfgUIDefault = $(do
      let path = "GameDefinition" </> "config.ui" <.> "default"
      qAddDependentFile path
      x <- qRunIO (readFile path)
      lift x)
  , rmainMenuArt = $(do
      let path = "GameDefinition/MainMenu.ascii"
      qAddDependentFile path
      x <- qRunIO (readFile path)
      lift x)
  , rfirstDeathEnds = False
  , rfovMode = Digital
  , rwriteSaveClips = 500
  , rleadLevelClips = 100
  , rscoresFile = "scores"
  , rsavePrefix = "save"
  , rnearby = 10
  }
