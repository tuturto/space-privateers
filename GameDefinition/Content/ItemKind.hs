-- | Weapon and treasure definitions.
module Content.ItemKind ( cdefs ) where

import Data.List

import Content.ItemKindActor
import Content.ItemKindOrgan
import Content.ItemKindShrapnel
import Content.ItemKindTemporary
import Game.LambdaHack.Common.Color
import Game.LambdaHack.Common.ContentDef
import Game.LambdaHack.Common.Dice
import Game.LambdaHack.Common.Flavour
import Game.LambdaHack.Common.Misc
import Game.LambdaHack.Content.ItemKind

cdefs :: ContentDef ItemKind
cdefs = ContentDef
  { getSymbol = isymbol
  , getName = iname
  , getFreq = ifreq
  , validateSingle = validateSingleItemKind
  , validateAll = validateAllItemKind
  , content = items ++ organs ++ shrapnels ++ actors ++ temporaries
  }

items :: [ItemKind]
items =
  [decipulum, brassLantern, buckler, dart, dart200, gem1, gem2, gem3, gloveFencing, gloveGauntlet, gloveJousting, currency, gorget, harpoon, oculus, necklace1, necklace2, necklace3, necklace4, necklace5, necklace6, necklace7, net, oilLamp, potion1, potion2, potion3, potion4, potion5, potion6, potion7, potion8, potion9, potion10, ring1, ring2, ring3, ring4, ring5, scroll1, scroll2, scroll3, scroll4, scroll5, scroll6, scroll7, scroll8, scroll9, shield, dagger, hammer, sword, halberd, wand1, wand2, armorLeather, armorMail, whetstone, grenade1, grenade2, grog, gladiusSolis]

decipulum,    brassLantern, buckler, dart, dart200, gem1, gem2, gem3, gloveFencing, gloveGauntlet, gloveJousting, currency, gorget, harpoon, oculus, necklace1, necklace2, necklace3, necklace4, necklace5, necklace6, necklace7, net, oilLamp, potion1, potion2, potion3, potion4, potion5, potion6, potion7, potion8, potion9, potion10, ring1, ring2, ring3, ring4, ring5, scroll1, scroll2, scroll3, scroll4, scroll5, scroll6, scroll7, scroll8, scroll9, shield, dagger, hammer, sword, halberd, wand1, wand2, armorLeather, armorMail, whetstone, grenade1, grenade2, grog, gladiusSolis :: ItemKind

gem, grenade, necklace, potion, ring, scroll, wand :: ItemKind  -- generic templates

symbolProjectile = '|'
_symbolLauncher = '}'
symbolLight = '('
symbolTool = '('
symbolGem = '*'
symbolGold = '$'
symbolNecklace = '"'
symbolRing = '='
symbolPotion = '!' -- concoction, bottle, jar, vial, canister
symbolFlask = '!'
symbolScroll = '?' -- book, note, tablet, remote
symbolTorsoArmor = '['
symbolMiscArmor = '['
_symbolClothes = '('
symbolShield = '['
symbolPolearm = ')'
symbolEdged = ')'
symbolHafted = ')'
symbolWand = '/' -- magical rod, transmitter, pistol, rifle
_symbolStaff = '_' -- scanner
_symbolFood = ','

-- * Thrown weapons

dart = ItemKind
  { isymbol  = symbolProjectile
  , iname    = "dart"
  , ifreq    = [("useful", 100), ("any arrow", 100), ("weapon", 100)]
  , iflavour = zipPlain [Cyan]
  , icount   = 3 * d 3
  , irarity  = [(1, 20)]
  , iverbHit = "prick"
  , iweight  = 50
  , iaspects = [AddHurtRanged ((d 6 + dl 6) |*| 10)]
  , ieffects = [Hurt (d 2)]
  , ifeature = []
  , idesc    = "Little, but sharp and sturdy."
  , ikit     = []
  }
dart200 = ItemKind
  { isymbol  = symbolProjectile
  , iname    = "fine dart"
  , ifreq    = [("useful", 100), ("any arrow", 50), ("weapon", 75)]
  , iflavour = zipPlain [BrRed]
  , icount   = 3 * d 3
  , irarity  = [(4, 20)]
  , iverbHit = "prick"
  , iweight  = 50
  , iaspects = [AddHurtRanged ((d 6 + dl 6) |*| 10)]
  , ieffects = [Hurt (d 2)]
  , ifeature = [toVelocity 200]
  , idesc    = "Finely balanced for throws of great speed."
  , ikit     = []
  }

-- * Exotic thrown weapons

decipulum = ItemKind
  { isymbol  = symbolProjectile
  , iname    = "decipulum majoris"
  , ifreq    = [("useful", 100), ("weapon", 50)]
  , iflavour = zipPlain [BrYellow]
  , icount   = dl 4
  , irarity  = [(5, 5), (10, 5)]
  , iverbHit = "entangle"
  , iweight  = 500
  , iaspects = []
  , ieffects = [Hurt (d 2), Paralyze (5 + d 5), ActivateInv '!']
  , ifeature = []
  , idesc    = "A web of springs in form of spheres. When thrown, this weapon can trip unwary opponents."
  , ikit     = []
  }
harpoon = ItemKind
  { isymbol  = symbolProjectile
  , iname    = "Force spear"
  , ifreq    = [("useful", 100), ("starting weapon", 100), ("weapon", 50)]
  , iflavour = zipPlain [Brown]
  , icount   = dl 5
  , irarity  = [(5, 5), (10, 20)]
  , iverbHit = "hook"
  , iweight  = 4000
  , iaspects = [AddHurtRanged ((d 2 + 2 * dl 5) |*| 10)]
  , ieffects = [Hurt (d 4), PullActor (ThrowMod 200 50)]
  , ifeature = []
  , idesc    = "The cruel, barbed head lodges in its victim so painfully that the weakest tug of the thin line sends the victim flying."
  , ikit     = []
  }
net = ItemKind
  { isymbol  = symbolProjectile
  , iname    = "net"
  , ifreq    = [("useful", 100), ("weapon", 60)]
  , iflavour = zipPlain [White]
  , icount   = dl 3
  , irarity  = [(3, 5), (10, 4)]
  , iverbHit = "entangle"
  , iweight  = 1000
  , iaspects = []
  , ieffects = [ Hurt (d 2)
               , Paralyze (5 + d 5)
               , DropBestWeapon, DropItem CEqp "torso armor" False ]
  , ifeature = []
  , idesc    = "A web made of monofilaments. Will both cut and entagle the prey."
  , ikit     = []
  }

-- * Lights

oilLamp = ItemKind
  { isymbol  = symbolLight
  , iname    = "oil lamp"
  , ifreq    = [("useful", 100)]
  , iflavour = zipPlain [BrYellow]
  , icount   = 1
  , irarity  = [(5, 4), (10, 4)]
  , iverbHit = "burn"
  , iweight  = 1000
  , iaspects = [AddLight 3, AddSight (-1)]
  , ieffects = [Burn 3, Paralyze 3, OnSmash (Explode "burning ignisium 3")]
  , ifeature = [ toVelocity 70
               , Fragile, EqpSlot EqpSlotAddLight "", Identified ]
  , idesc    = "A clay lamp filled with ignisium feeding a tiny wick."
  , ikit     = []
  }
brassLantern = ItemKind
  { isymbol  = symbolLight
  , iname    = "brass lantern"
  , ifreq    = [("useful", 100)]
  , iflavour = zipPlain [BrWhite]
  , icount   = 1
  , irarity  = [(10, 3)]
  , iverbHit = "burn"
  , iweight  = 2400
  , iaspects = [AddLight 4, AddSight (-1)]
  , ieffects = [Burn 4, Paralyze 4, OnSmash (Explode "burning ignisium 4")]
  , ifeature = [ toVelocity 70  -- hard to throw so that it opens and burns
               , Fragile, EqpSlot EqpSlotAddLight "", Identified ]
  , idesc    = "Very bright and very heavy brass lantern."
  , ikit     = []
  }

-- * Treasure

gem = ItemKind
  { isymbol  = symbolGem
  , iname    = "gem"
  , ifreq    = [("treasure", 100), ("gem", 100)]
  , iflavour = zipPlain $ delete BrYellow brightCol
  , icount   = 1
  , irarity  = []
  , iverbHit = "tap"
  , iweight  = 50
  , iaspects = [AddLight 1, AddSpeed (-1)]
  , ieffects = []
  , ifeature = [ Durable
               , Precious ]
  , idesc    = "Useless, and still worth around 100 gold each. Would gems of thought and pearls of artful design be valued that much in our age of Science and Progress!"
  , ikit     = []
  }
gem1 = gem
  { irarity  = [(2, 0), (10, 10)]
  }
gem2 = gem
  { irarity  = [(5, 0), (10, 10)]
  }
gem3 = gem
  { irarity  = [(8, 0), (10, 10)]
  }
currency = ItemKind
  { isymbol  = symbolGold
  , iname    = "gold piece"
  , ifreq    = [("treasure", 100), ("currency", 100)]
  , iflavour = zipPlain [BrYellow]
  , icount   = 10 + d 20 + dl 20
  , irarity  = [(1, 0), (5, 20), (10, 10)]
  , iverbHit = "tap"
  , iweight  = 31
  , iaspects = []
  , ieffects = []
  , ifeature = [Durable, Identified, Precious]
  , idesc    = "Reliably valuable in every civilized plane of existence."
  , ikit     = []
  }

-- * Periodic jewelry

gorget = ItemKind
  { isymbol  = symbolNecklace
  , iname    = "gorget"
  , ifreq    = [("useful", 100)]
  , iflavour = zipFancy [BrCyan]
  , irarity  = [(4, 1), (10, 2)]
  , icount   = 1
  , iverbHit = "whip"
  , iweight  = 30
  , iaspects = [ Periodic
               , Timeout $ (d 3 + 3 - dl 3) |*| 10
               , AddArmorMelee 1
               , AddArmorRanged 1 ]
  , ieffects = [RefillCalm 1]
  , ifeature = [ Precious, EqpSlot EqpSlotPeriodic "", Identified
               , toVelocity 50 ]
  , idesc    = "Highly ornamental, cold, large, steel medallion on a chain. Unlikely to offer much protection as an armor piece, but the old, worn engraving reassures you."
  , ikit     = []
  }
necklace = ItemKind
  { isymbol  = symbolNecklace
  , iname    = "necklace"
  , ifreq    = [("useful", 100)]
  , iflavour = zipFancy stdCol ++ zipPlain brightCol
  , irarity  = [(4, 2), (10, 5)]
  , icount   = 1
  , iverbHit = "whip"
  , iweight  = 30
  , iaspects = [ Periodic ]
  , ieffects = []
  , ifeature = [ Precious, EqpSlot EqpSlotPeriodic ""
               , toVelocity 50 ]
  , idesc    = "Menacing Greek symbols shimmer with increasing speeds along a chain of fine encrusted links. After a tense build-up, a prismatic arc shoots towards the ground and the iridescence subdues, becomes ordered and resembles a harmless ornament again, for a time."
  , ikit     = []
  }
necklace1 = necklace
  { iaspects = (Timeout $ (d 2 + dl 2)) : iaspects necklace
  , ieffects = [ RefillHP 1 ]
  , idesc    = "A cord of dried herbs and healing berries."
  }
necklace2 = necklace
  { irarity  = [(2, 0), (10, 1)]
  , iaspects = (Timeout $ (d 4 + dl 2)) : iaspects necklace
  , ieffects = [ Impress
               , Summon [("summonable animal", 1)] $ 1 + dl 2, Explode "waste" ]
  }
necklace3 = necklace
  { iaspects = (Timeout $ (d 4 + dl 2)) : iaspects necklace
  , ieffects = [ Paralyze $ 5 + d 5 + dl 5, RefillCalm 999 ]
  }
necklace4 = necklace
  { iaspects = (Timeout $ (2 * d 10 + dl 10)) : iaspects necklace
  , ieffects = [ Teleport $ 2 + d 3 ]
  }
necklace5 = necklace
  { iaspects = (Timeout $ (d 4 + dl 2)) : iaspects necklace
  , ieffects = [ Teleport $ 10 + d 10 ]
  }
necklace6 = necklace
  { iaspects = (Timeout $ (2 * d 5 + dl 5)) : iaspects necklace
  , ieffects = [ PushActor (ThrowMod 100 50) ]
  }
necklace7 = necklace
  { irarity  = [ (4, 0), (10, 2) ]
  , iaspects = (Timeout $ (2 * d 5 + dl 15)) : iaspects necklace
  , ieffects = [ InsertMove 1, RefillHP (-1) ]
  , ifeature = ifeature necklace ++ [ Durable ]
      -- evil players would throw before death, to destroy
      -- TODO: teach AI to wear only for fight; prevent players from meleeing
      -- allies with that (Durable)
  }

-- * Non-periodic jewelry

oculus = ItemKind
  { isymbol  = '='
  , iname    = "oculus cursus"
  , ifreq    = [("useful", 100)]
  , iflavour = zipPlain [White]
  , icount   = 1
  , irarity  = [(6, 0), (10, 1)]
  , iverbHit = "rap"
  , iweight  = 50
  , iaspects = [AddSight $ dl 3]
  , ieffects = []
  , ifeature = [Precious, Identified, Durable, EqpSlot EqpSlotAddSight ""]
  , idesc    = "Arcane device to boost your sight."
  , ikit     = []
  }
ring = ItemKind
  { isymbol  = symbolRing
  , iname    = "ring"
  , ifreq    = [("useful", 100)]
  , iflavour = zipPlain stdCol ++ zipFancy darkCol
  , icount   = 1
  , irarity  = [(6, 2), (10, 5)]
  , iverbHit = "knock"
  , iweight  = 15
  , iaspects = []
  , ieffects = []
  , ifeature = [Precious, Identified]
  , idesc    = "It looks like an ordinary object, but it's in fact a generator of exceptional effects: adding to some of your natural abilities and subtracting from others. You'd profit enormously if you could find a way to multiply such generators..."
  , ikit     = []
  }
ring1 = ring
  { irarity  = [(2, 0), (10, 2)]
  , iaspects = [AddSpeed 1, AddMaxHP $ dl 3 - 5 - d 3]
  , ifeature = ifeature ring ++ [Durable, EqpSlot EqpSlotAddSpeed ""]
  }
ring2 = ring
  { iaspects = [AddMaxHP $ 3 + dl 5, AddMaxCalm $ dl 6 - 15 - d 6]
  , ifeature = ifeature ring ++ [EqpSlot EqpSlotAddMaxHP ""]
  }
ring3 = ring
  { iaspects = [AddMaxCalm $ 10 + dl 10]
  , ifeature = ifeature ring ++ [EqpSlot EqpSlotAddMaxCalm ""]
  , idesc    = "Cold, solid to the touch, perfectly round, engraved with solemn, strangely comforting, worn out words."
  }
ring4 = ring  -- TODO: move to level-ups and to timed effects
  { irarity  = [(3, 8), (10, 12)]
  , iaspects = [AddHurtMelee $ 3 * d 4 + dl 15, AddMaxHP $ dl 3 - 4 - d 2]
  , ifeature = ifeature ring ++ [Durable, EqpSlot EqpSlotAddHurtMelee ""]
  }
ring5 = ring  -- by the time it's found, probably no space in eqp
  { irarity  = [(5, 0), (10, 1)]
  , iaspects = [AddLight $ d 2]
  , ifeature = ifeature ring ++ [EqpSlot EqpSlotAddLight ""]
  , idesc    = "A sturdy ring with a large, shining stone."
  }

-- * Exploding consumables, often intended to be thrown

potion = ItemKind
  { isymbol  = symbolPotion
  , iname    = "vial"
  , ifreq    = [("useful", 100), ("any vial", 100)]
  , iflavour = zipPlain stdCol ++ zipFancy brightCol
  , icount   = 1
  , irarity  = [(1, 10), (10, 8)]
  , iverbHit = "splash"
  , iweight  = 200
  , iaspects = []
  , ieffects = []
  , ifeature = [ toVelocity 50
               , Applicable, Fragile ]
  , idesc    = "A flask of bubbly, slightly oily liquid of a suspect color."
  , ikit     = []
  }
potion1 = potion
  { ieffects = [ NoEffect "of rose water", Impress
               , OnSmash (ApplyPerfume), OnSmash (Explode "fragrance") ]
  }
potion2 = potion
  { ifreq    = [("useful", 1)]
  , irarity  = [(10, 1)]
  , ieffects = [ NoEffect "of musky concoction", Impress, DropBestWeapon
               , OnSmash (Explode "pheromone")]
  }
potion3 = potion
  { ieffects = [RefillHP 5, OnSmash (Explode "healing mist")]
  }
potion4 = potion
  { irarity  = [(1, 5)]
  , ieffects = [RefillHP (-5), OnSmash (Explode "wounding mist")]
  }
potion5 = potion
  { ieffects = [ Explode "explosion blast 10", Impress
               , PushActor (ThrowMod 200 75)
               , OnSmash (Explode "explosion blast 10") ]
  }
potion6 = potion
  { irarity  = [(10, 2)]
  , ieffects = [ NoEffect "of distortion"
               , OnSmash (Explode "distortion")]
  }
potion7 = potion
  { ieffects = [ NoEffect "of bait cocktail", Impress
               , OnSmash (Summon [("summonable animal", 1)] $ 1 + dl 2)
               , OnSmash (Explode "waste") ]
  }
potion8 = potion
  { ieffects = [ OneOf [Impress, DropBestWeapon, RefillHP 5, Burn 3]
               , OnSmash (OneOf [ Explode "healing mist"
                                , Explode "wounding mist"
                                , Explode "fragrance"
                                , Explode "explosion blast 10" ]) ]
  }
potion9 = potion
  { irarity  = [(4, 1), (10, 2)]
  , ieffects = [ OneOf [ Dominate, DropBestWeapon, RefillHP 15, Burn 9
                       , InsertMove 2]
               , OnSmash (OneOf [ Explode "healing mist"
                                , Explode "healing mist"
                                , Explode "pheromone"
                                , Explode "distortion"
                                , Explode "explosion blast 20" ]) ]
  }
potion10 = potion
  { ifreq    = [("useful", 100), ("potion of glue", 1)]
  , irarity  = [(1, 1)]
  , icount   = 1 + d 2
  , ieffects = [ NoEffect "of glue", Paralyze (5 + d 5)
               , OnSmash (Explode "glue")]
  }
grenade = ItemKind
  { isymbol  = '*'
  , iname    = "grenade"
  , ifreq    = [("useful", 100), ("weapon", 25)]
  , iflavour = zipPlain stdCol ++ zipFancy brightCol
  , icount   = 1
  , irarity  = [(1, 1), (10, 3)]
  , iverbHit = "explode"
  , iweight  = 200
  , iaspects = []
  , ieffects = []
  , ifeature = [ toVelocity 200
               , Fragile
               , Identified ]
  , idesc    = "Small metal canister, with safety latch and finely engraved surface."
  , ikit     = []
  }
grenade1 = grenade
  { irarity  = [(1, 1), (10, 3)]
  , ieffects = [ NoEffect "of explosionis"
               , OnSmash (Explode "explosion blast 10") ]
  }
grenade2 = grenade
  { irarity  = [(1, 1), (10, 3)]
  , ieffects = [ NoEffect "of ignisium"
               , OnSmash (Explode "burning ignisium 2") ]
  }
-- * Non-exploding consumables, not specifically designed for throwing
grog = ItemKind
  { isymbol  = symbolPotion
  , iname    = "grog tankard"
  , ifreq    = [("useful", 100)]
  , iflavour = zipPlain [Brown]
  , icount   = 1
  , irarity  = [(1, 3), (10, 1)]
  , iverbHit = "splash"
  , iweight  = 50
  , iaspects = []
  , ieffects = [ RefillCalm 30, Paralyze (3 + d 5)]
  , ifeature = [ toVelocity 25
               , Applicable, Identified ]
  , idesc    = "A tankard full of disgusting looking liquid, probably containing at least one or more of the following: kerosene, propylene glycol, sulphuric acid, rum, acetone, scumm, axle grease and battery acid."
  , ikit     = []
  }

scroll = ItemKind
  { isymbol  = symbolScroll
  , iname    = "scroll"
  , ifreq    = [("useful", 100), ("any scroll", 100)]
  , iflavour = zipFancy stdCol ++ zipPlain darkCol
  , icount   = 1
  , irarity  = [(1, 10), (10, 7)]
  , iverbHit = "thump"
  , iweight  = 50
  , iaspects = []
  , ieffects = []
  , ifeature = [ toVelocity 25
               , Applicable ]
  , idesc    = "Scraps of haphazardly scribbled mysteries from beyond. Is this equation an alchemical recipe? Is this diagram an extradimensional map? Is this formula a secret call sign?"
  , ikit     = []
  }
scroll1 = scroll
  { irarity  = [(10, 2)]
  , ieffects = [CallFriend 1]
  }
scroll2 = scroll
  { irarity  = [(1, 5), (10, 3)]
  , ieffects = [NoEffect "of fireworks", Explode "firecracker 7"]
  }
scroll3 = scroll
  { irarity  = [(1, 4), (10, 2)]
  , ieffects = [Ascend (-1)]
  }
scroll4 = scroll
  { ieffects = [ OneOf [ Teleport 5, RefillCalm 10, RefillCalm (-10)
                       , InsertMove 4, Paralyze 10 ] ]
  }
scroll5 = scroll
  { irarity  = [(1, 4), (10, 6)]
  , ieffects = [ OneOf [ Summon standardSummon $ d 2
                       , CallFriend 1, Ascend (-1), Ascend 1
                       , RefillCalm 30, RefillCalm (-30)
                       , CreateItem CGround "useful" TimerNone ] ]
               -- TODO: ask player: Escape 1
  }
scroll6 = scroll
  { ieffects = [Teleport $ 2 + d 5]
  }
scroll7 = scroll
  { irarity  = [(10, 2)]
  , ieffects = [InsertMove $ d 2 + dl 2]
  }
scroll8 = scroll
  { irarity  = [(3, 6), (10, 3)]
  , ieffects = [Identify]  -- TODO: ask player: AskPlayer cstore eff?
  }
scroll9 = scroll
  { irarity  = [(3, 3), (10, 9)]
  , ieffects = [PolyItem]
  }

standardSummon :: Freqs ItemKind
standardSummon = [("summonable animal", 100)]

-- * Armor

armorLeather = ItemKind
  { isymbol  = symbolTorsoArmor
  , iname    = "leather armor"
  , ifreq    = [("useful", 100), ("armour", 100)]
  , iflavour = zipPlain [Brown]
  , icount   = 1
  , irarity  = [(4, 9)]
  , iverbHit = "thud"
  , iweight  = 7000
  , iaspects = [ AddHurtMelee (-3)
               , AddArmorMelee $ (1 + dl 3) |*| 5
               , AddArmorRanged $ (1 + dl 3) |*| 5 ]
  , ieffects = []
  , ifeature = [ toVelocity 30
               , Durable, EqpSlot EqpSlotAddArmorMelee "", Identified ]
  , idesc    = "A stiff jacket formed from leather boiled in bee wax. Smells much better than the rest of your garment."
  , ikit     = []
  }
armorMail = armorLeather
  { iname    = "mail armor"
  , iflavour = zipPlain [Cyan]
  , irarity  = [(7, 9)]
  , iweight  = 12000
  , iaspects = [ AddHurtMelee (-3)
               , AddArmorMelee $ (2 + dl 3) |*| 5
               , AddArmorRanged $ (2 + dl 3) |*| 5 ]
  , idesc    = "A long shirt woven from iron rings. Discourages foes from attacking your torso, making it harder for them to land a blow."
  }
gloveFencing = ItemKind
  { isymbol  = symbolMiscArmor
  , iname    = "leather gauntlet"
  , ifreq    = [("useful", 100), ("armour", 100)]
  , iflavour = zipPlain [BrYellow]
  , icount   = 1
  , irarity  = [(4, 6), (10, 12)]
  , iverbHit = "flap"
  , iweight  = 100
  , iaspects = [ AddHurtMelee $ 2 * (d 3 + 2 * dl 5)
               , AddArmorRanged $ d 2 + dl 2 ]
  , ieffects = []
  , ifeature = [ toVelocity 30
               , Durable, EqpSlot EqpSlotAddArmorRanged "", Identified ]
  , idesc    = "A fencing glove from rough leather ensuring a good grip. Also quite effective in deflecting or even catching slow projectiles."
  , ikit     = []
  }
gloveGauntlet = gloveFencing
  { iname    = "steel gauntlet"
  , irarity  = [(6, 12)]
  , iflavour = zipPlain [BrCyan]
  , iweight  = 300
  , iaspects = [ AddArmorMelee $ 2 * (d 2 + dl 2)
               , AddArmorRanged $ 2 * (d 2 + dl 2) ]
  , idesc    = "Long leather gauntlet covered in overlapping steel plates."
  }
gloveJousting = gloveFencing
  { iname    = "jousting gauntlet"
  , irarity  = [(6, 6)]
  , iflavour = zipFancy [BrRed]
  , iweight  = 500
  , iaspects = [ AddHurtMelee $ - 10 - d 5 + dl 5
               , AddArmorMelee $ 2 * (d 2 + dl 3)
               , AddArmorRanged $ 2 * (d 2 + dl 3) ]
  , idesc    = "Rigid, steel, jousting handgear. If only you had a lance. And a horse."
  }

buckler = ItemKind
  { isymbol  = symbolShield
  , iname    = "buckler"
  , ifreq    = [("useful", 100), ("armour", 100)]
  , iflavour = zipPlain [Blue]
  , icount   = 1
  , irarity  = [(4, 7)]
  , iverbHit = "bash"
  , iweight  = 2000
  , iaspects = [AddArmorMelee 40, AddHurtMelee (-30)]
  , ieffects = []
  , ifeature = [ toVelocity 30
               , Durable, EqpSlot EqpSlotAddArmorMelee "", Identified ]
  , idesc    = "Heavy and unwieldy. Absorbs a percentage of melee damage, both dealt and sustained. Too small to intercept projectiles with."
  , ikit     = []
  }
shield = buckler
  { iname    = "shield"
  , irarity  = [(7, 7)]
  , iflavour = zipPlain [Green]
  , iweight  = 3000
  , iaspects = [AddArmorMelee 80, AddHurtMelee (-70)]
  , ifeature = [ toVelocity 20
               , Durable, EqpSlot EqpSlotAddArmorMelee "", Identified ]
  , idesc    = "Large and unwieldy. Absorbs a percentage of melee damage, both dealt and sustained. Too heavy to intercept projectiles with."
  }

-- * Weapons

dagger = ItemKind
  { isymbol  = symbolEdged
  , iname    = "dagger"
  , ifreq    = [("useful", 100), ("starting weapon", 100), ("weapon", 100)]
  , iflavour = zipPlain [BrCyan]
  , icount   = 1
  , irarity  = [(1, 20), (10, 4)]
  , iverbHit = "stab"
  , iweight  = 1000
  , iaspects = [AddHurtMelee $ 2 * (d 3 + 2 * dl 5), AddArmorMelee $ d 4 + dl 4]
  , ieffects = [Hurt (d 4)]
  , ifeature = [ toVelocity 40
               , Durable, EqpSlot EqpSlotWeapon "", Identified ]
  , idesc    = "A short dagger for thrusting and parrying blows. Does not penetrate deeply, but is hard to block. Especially useful in conjunction with a larger weapon."
  , ikit     = []
  }
hammer = ItemKind
  { isymbol  = ')'
  , iname    = "storm hammer"
  , ifreq    = [("useful", 100), ("weapon", 60), ("starting weapon", 100)]
  , iflavour = zipPlain [BrMagenta]
  , icount   = 1
  , irarity  = [(4, 12), (10, 2)]
  , iverbHit = "club"
  , iweight  = 1500
  , iaspects = [AddHurtMelee $ d 3 + 2 * dl 5]
  , ieffects = [Hurt (d 6), PushActor (ThrowMod 200 50)]
  , ifeature = [ toVelocity 20
               , Durable, EqpSlot EqpSlotWeapon "", Identified ]
  , idesc    = "Mighty hammer that releases blast of electricity when it hits target."
  , ikit     = []
  }
sword = ItemKind
  { isymbol  = symbolEdged
  , iname    = "sword"
  , ifreq    = [("useful", 100), ("starting weapon", 100), ("weapon", 75)]
  , iflavour = zipPlain [BrBlue]
  , icount   = 1
  , irarity  = [(3, 1), (6, 20), (10, 10)]
  , iverbHit = "slash"
  , iweight  = 2000
  , iaspects = []
  , ieffects = [Hurt (d 8)]
  , ifeature = [ toVelocity 20
               , Durable, EqpSlot EqpSlotWeapon "", Identified ]
  , idesc    = "Common vibroblade, favoured by those who like to get close and personal."
  , ikit     = []
  }
halberd = ItemKind
  { isymbol  = symbolPolearm
  , iname    = "halberd"
  , ifreq    = [("useful", 100), ("weapon", 50)]
  , iflavour = zipPlain [BrYellow]
  , icount   = 1
  , irarity  = [(7, 1), (10, 10)]
  , iverbHit = "impale"
  , iweight  = 3000
  , iaspects = [AddArmorMelee $ 2 * (d 4 + dl 4)]
  , ieffects = [Hurt (d 12)]
  , ifeature = [ toVelocity 20
               , Durable, EqpSlot EqpSlotWeapon "", Identified ]
  , idesc    = "Versatile, with great reach and leverage. Foes are held at a distance."
  , ikit     = []
  }
gladiusSolis = ItemKind
  { isymbol  = symbolEdged
  , iname    = "gladius solis"
  , ifreq    = [("useful", 100), ("weapon", 1)]
  , iflavour = zipPlain [BrWhite]
  , icount   = 1
  , irarity  = [(1, 1), (10, 10)]
  , iverbHit = "slash"
  , iweight  = 2000
  , iaspects = [ AddLight 2, AddHurtMelee 25, Unique ]
  , ieffects = [Hurt (d 8)]
  , ifeature = [ toVelocity 20
               , Precious, Durable, EqpSlot EqpSlotWeapon "", Identified ]
  , idesc    = "Sword of light, emanating cold light."
  , ikit     = []
  }
-- * Wands

wand = ItemKind
  { isymbol  = symbolWand
  , iname    = "wand"
  , ifreq    = [("useful", 100)]
  , iflavour = zipFancy brightCol
  , icount   = 1
  , irarity  = []  -- TODO: add charges, etc.
  , iverbHit = "club"
  , iweight  = 300
  , iaspects = [AddLight 1, AddSpeed (-1)]
  , ieffects = []
  , ifeature = [ toVelocity 125
               , Applicable, Durable ]
  , idesc    = "Buzzing with dazzling light that shines even through appendages that handle it."
  , ikit     = []
  }
wand1 = wand
  { ieffects = []
  }
wand2 = wand
  { ieffects = []
  }

-- * Assorted tools

whetstone = ItemKind
  { isymbol  = '~'
  , iname    = "whetstone"
  , ifreq    = [("useful", 100)]
  , iflavour = zipPlain [Blue]
  , icount   = 1
  , irarity  = [(5, 5)]
  , iverbHit = "smack"
  , iweight  = 400
  , iaspects = [AddHurtMelee $ 2 * (d 3 + 2 * dl 5)]
  , ieffects = []
  , ifeature = [EqpSlot EqpSlotAddHurtMelee "", Identified]
  , idesc    = "A portable sharpening stone that lets you fix your weapons between or even during fights, without the need to set up camp, fish out tools and assemble a proper sharpening workshop."
  , ikit     = []
  }
