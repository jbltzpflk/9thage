
Forces of Destruction = [:DK,:OG,:WC,:DC,:SK,:VC,:BS]
Forces of Order = [:EM,:HE,:DW,:BR,:WE,:LZ]
Neutral Forces = [:OK,:TK,]

Arrows of Isha: Shooting attacks by Figure are Magical. Against ForcesOfDestruction, TargetFigure suffers -1 ArmorSave penalty this attack.

	trigger 
		queue :shooting
		filter :attacker :figure
		attack.addTag :magic

	trigger
		queue :shooting
		filter :attacker :figure
		filter :target tags.containsAny [:DK,:OG,:WC,:DC,:SK,:VC,:BS]
		attack.armorRoll.penalties.append(-1)



AttunedToMagic = WardSave 5+, MagicalAttacks, each ControllingPlayer's WindsOfMagic phase roll D6: lasts until next CP WoM phase
1 MagicalDearth Phoenix's WardSave is 6+
2 EbbingZephyr Phoenix S@-1 penalty
3 MagicalDraught Phoenix I@+1 bonus
4 EnergizingBreeze Phoenix A@+1 bonus
5 InvigoratingWinds Phoenix S@+1 bonus
6 HowlingGale Phoenix WardSave 4+

	figure.wardSave = 5

	trigger
		queue :cc
		filter :attacker :figure
		attack.addTag :magic

	trigger


Blessings of Asuryan: Figure and Regiment have WardSave 6+ and ImmunePsych
BlizzardAura: All EnemyFigures in BaseContact with Figure have ASL and penalty to S@-1 
Boon of Isha: All attacks by Figure's Regiment are Magical. Figure's Regiment immuneFear immuneTerror
Chaos Bane: Start of each of Figure's Magic phase, before roll WindsOfMagic, all Daemonic Regiments in 12" aura range suffer D6@S4 Hits distrib as shooting. If any Daemonic Figures in 12" aura range, Alarielle suffers -3 penalty to casting rolls.
Defender of Ulthuan: If Figure is General, Inspiring Presence Aura range 18
Deflect Shots: Figure gains 6+ WardSave vs non-magic, non-template shooting attacks
Fireborn: Figure gains 2+ WardSave vs Wounds caused by Attacks with FlamingAttacks
Lileaths Blessing: Figure gains bonus +1 to all casting rolls when casting HighMagic spells
Mark of Asuryan: If Caradryan killed in CC, Regiment that killed him suffers D3 Wounds no AS, counts toward CR. In Challenge applies only to opponent, excess counts toward overkill. 
Martial Prowess: Regiment gains bonus +1 allowed additional rank when making supporting attacks
NaturalArmor: ArmorSave 5+
Naval Discipline: If Figure's Regiment successfully charged during Movement phase and Regiment has not made a StandAndShoot or Flee move that turn, Regiment takes Ld test, on pass: may make combat reform. 
Phoenix Reborn
When Figure loses last Wound, includes dying by HeroicKillingBlow or MultipleWounds, remove Figure, place PhoenixReborn counter.  (Distinguish counters for each Figure). 
Record whether Figure had a living Rider when it died, configuration of Rider.
Every turn: Roll D6 for each PhoenixReborn counter, bonus +1 if had living rider.
Roll 	Result
1-2		DeadEmbers - Remove Counter
3-5		FlameKindled - Center LargeTemplate on center of Counter. All figures touching template suffer 1@S4 FlamingAttacks hit.
6+		RiseFromAshes - Counter's ControllingPlayer select location within 6" from center of Counter, >1" from any Regiment, remove Counter.
		If no location available treat as FlameKindled. ** do we still remove the counter if cant do RiseFromAshes? **
		At selected Location, create 1 Flamespyre Phoenix, with D3+2 Wounds. 
		If Counter associated with a Rider, add Rider to Phoenix, as originally deployed.
At end of game, all counters removed, treat counters and associated riders as casualties.

QuicksilverShot: Figure and all Sisters in Figure's Regiment have QuickToFire
Reckless: Figure gains bonus +2 to casting rolls, all dispel bonuses are negated.
ShreddingTalons = ArmorPiercing
Swiftsense = ASF
SwoopingStrike = DevastatingCharge, S@+1 on charge
Touch of the Everqueen: Alarielle's CC attacks are HeroicKillingBlow if against EnemyFigure of ForceOfDestruction(=Orc,DK,Chaos,Skaven,VC)
Valor of Ages: If Opponent's Army contains any DarkElf figures, Figure reroll all failed Panic, Fear, Terror tests.
WarriorMage: First spell generated is FlamingSwordofRhuin
Witness to Destiny: WardSave 4+
Windrider: If Figure mounted on a Skycutter, Figure and Mount have WardSave 4+ vs shooting. Figure rerolls DangerousTerrain tests.

Armory of Ulthuan
Bow of Avelorn: ShootingWeapon, Range 24", S4, ArrowsOfIsha,FlamingAttacks,VolleyFire
Dragon Armor: Armor, Wearer has 5+ ArmorSave, 6+ WardSave, Fireborn
Eagle Eye Bolt Thrower: ShootingWeapon, Range 24 @S5, MultipleWounds D3, Ignore ArmorSave
Ithilmar Barding: Barding, Negates Barding Movement penalty
LionCloak: Cloak, Figure gains bonus +2 to ArmorSave vs non-magical ShootingAttacks


Magic items
Chayal: MW, Korhil only, CC(@S+2,KillingBlow), counts as PairedWeapon with Wielder's HandWeapon
Fangsword of Eltharion: MW, Eltharion only, Bonus S@+2, ignores ArmorSave
PhoenixBlade: MW, Caradryan only, CC:(S@+1,FlamingAttacks,MultipleWounds(D3)
Sunfang MW, Tyrion only, Hits bonus S@+3 FlamingAttacks, bearer can make BreathWeapon attack S@4 Flaming Magical attacks once per game .
Sword of Teclis: MW, Teclis only, Wounds on 2+, ignores ArmorSave
AenarionDragonArmor: MA, Tyrion only, ArmorSave 1+ cannot be improved further. WardSave 4+, Wearer is Fireborn.
Helm of Yvresse: MA, Eltharion only, Bonus +1 ArmorSave, Wearer and Wearer's Mount gain 5+ WardSave
Heart of Avelorn: E, Tyrion only, Bearer has MR(2), if Bearer is killed, roll D6: on 1 dies, on 2+ killing Wound negated, Item destroyed.
MoonStaff of Lileath: A, Teclis only, one use per game, declare at start of bearer's Magic phase add bonus +1 die to each casting attempt, must also use at least 1 die from PowerPool each attempt, or declare use before roll on miscast table, ignore result of miscast. After use Bearer's S and T reduced to 1 for rest of game.
Scroll of Hoeth: A, Teclis only, dispel scroll, after use, caster and Teclis roll D6 each - if Teclis rolls higher caster forgets spell.
War Crown of Saphery: A, Teclis only, Wearer gains bonus 1 Wizard level.
Talisman of Hoeth: T, Eltharion only, MR(1), Bearer becomes Wizard(2) Lore(one of Fire,Metal,Beasts,Light,Life,Death,Heavens,Shadow)
Stone of Midnight: T, Alith Anar only, Bearer has WardSave 4+, EnemyFigures shooting at Bearer or Bearer's Regiment suffer -1 toHit
ShadowCrown: E ,Alith Anar only, Bearer and Bearer's Regiment have Swiftstride.
Moonbow: MW, Alith Anar only, Bow Range 36 S@7 MultipleWounds(D3) QuickToFire, Bearer can shoot if moves(not march), ignores ArmorSave, if inflicts casualties on DK Regiment - inflicts -1 penalty to Ld on that Regiment duration until end of phase.
Shieldstone of Isha: T, Alarielle only, Bearer and Regiment WardSave 5+ vs non-magical Attacks
Star of Avelorn: E, Alarielle only, range 12", start of own Movement phase pick 1 friendly character in range, selected figure regains 1 lost Wound, Alarielle can restore own lost wounds iff no friendly character in range.
Stave of Avelorn: A, Alarielle only, one use only, allows repeat casting of a spell even if fail or miscast first time.
Pelt of Charandis: T, Korhil only, Wearer has bonus +1AS vs CC, +2AS vs nonmagical shooting, Poisoned atttacks must roll to wound wearer.


If Alarielle in Army, following items available:
Horn of Isha: E, 50, Handmaiden only, only avail if Alarielle in army, use at start of own Movement phase, one use only, all Figures in Bearer's Regiment bonus +1 hitroll on shooting and CC attacks.
Banner of Avelorn: B, 40, BSB only, only avail if Alarielle in Army, Spells from Lore(Light) or Lore(Life) cast by friendly Wizard targeting ContainingRegiment gain bonus +4 to castingroll. If Alarielle killed, bonus is lost.



Vaul's Forge
Magic items available to High Elves armies
Blade of Leaping Gold, MW, 70, HandWeapon,Wielder gains bonus +3A, Woundrolls of 6 ignore ArmorSave.
Star Lance, MW, 30, CavLance, Mounted character only, only usable on successful charge, bonus S@+3, ignore ArmorSave.
Reaver Bow, MW, 25, Bow, Range 30, S@+1, VolleyFire, MultipleShot(3).
Armor of Caledor, MA, 50, ArmorSave 2+ CBIAM, WardSave 6+, Fireborn
Shadow Armor, MA, 25, ArmorSave 5+, Scouts, Strider.
Shield of the Merwyrm, MA, 15, Shield, Bearer has parry save 4+ even if using MW, unless using Req2H weapon.
Golden Crown of Atrazar, T, 10, One use only, WardSave 2+ vs 1st wounding hit suffered by Wearer, cancels Wound and any KillingBlow/MultiWounds.
Moranions Wayshard, E, 50, Figure on foot only, Bearer has Ambushers, applies to Bearer's Regiment of up to 30 Archers or Spearmen (HighElves only) at deployment, Bearer must remain with Regiment 1 turn after deployment.
Khaines Ring of Fury, E, 25, BoundSpell, PL3, SoulQuench
Gem of Sunfire, E, 20, One use only, duration 1 turn, Bearer and Mount gain bonus +1 on all CastingRoll, WR(CC and shooting) (roll of 1 still fails), CC and shooting count as FlamingAttacks.
Cloak of Beards, E, 10, Wearer CauseFear, (vs Dwarfs CauseTerror, Dwarfs Hate(Wearer)), each CC phase Dwarfs in BC with Wearer roll D6 for each magic item they carry, on 4+ item destroyed (does not apply to mounts, boundspells that have misfired, usedup onuseonly items).
Book of Hoeth, A, 55, Bearer can reroll one dice from each of own casting and dispel attempts. Cannot reroll 6's.
Banner of the World Dragon, B, 50, Figures in Bearer's Regiment have WardSave 2+ vs wounds caused by spells, magic weapons, magical attacks. All Dragons(friendly and enemy) in 12" aura range are Stubborn.
