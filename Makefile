# All xc* tests assume a profiling build (for stack traces).
# See the install-debug target below.

install-debug:
	cabal install --enable-library-profiling --enable-executable-profiling --ghc-options="-fprof-auto-calls" --disable-optimization

configure-debug:
	cabal configure --enable-library-profiling --enable-executable-profiling --ghc-options="-fprof-auto-calls" --disable-optimization


xcplay:
	dist/build/SpacePrivateers/SpacePrivateers +RTS -xc -RTS --dbgMsgSer --dumpInitRngs

xcfrontendCampaign:
	dist/build/SpacePrivateers/SpacePrivateers +RTS -xc -RTS --dbgMsgSer --savePrefix test --newGame 1 --maxFps 60 --dumpInitRngs --automateAll --gameMode campaign

xcfrontendRaid:
	dist/build/SpacePrivateers/SpacePrivateers +RTS -xc -RTS --dbgMsgSer --savePrefix test --newGame 5 --maxFps 60 --dumpInitRngs --automateAll --gameMode raid

xcfrontendSkirmish:
	dist/build/SpacePrivateers/SpacePrivateers +RTS -xc -RTS --dbgMsgSer --savePrefix test --newGame 5 --maxFps 60 --dumpInitRngs --automateAll --gameMode skirmish

xcfrontendAmbush:
	dist/build/SpacePrivateers/SpacePrivateers +RTS -xc -RTS --dbgMsgSer --savePrefix test --newGame 5 --maxFps 60 --dumpInitRngs --automateAll --gameMode ambush

xcfrontendBattle:
	dist/build/SpacePrivateers/SpacePrivateers +RTS -xc -RTS --dbgMsgSer --savePrefix test --newGame 2 --maxFps 60 --dumpInitRngs --automateAll --gameMode battle

xcfrontendBattleSurvival:
	dist/build/SpacePrivateers/SpacePrivateers +RTS -xc -RTS --dbgMsgSer --savePrefix test --newGame 8 --maxFps 60 --dumpInitRngs --automateAll --gameMode "battle survival"

xcfrontendSafari:
	dist/build/SpacePrivateers/SpacePrivateers +RTS -xc -RTS --dbgMsgSer --savePrefix test --newGame 2 --maxFps 60 --dumpInitRngs --automateAll --gameMode safari

xcfrontendSafariSurvival:
	dist/build/SpacePrivateers/SpacePrivateers +RTS -xc -RTS --dbgMsgSer --savePrefix test --newGame 8 --maxFps 60 --dumpInitRngs --automateAll --gameMode "safari survival"

xcfrontendDefense:
	dist/build/SpacePrivateers/SpacePrivateers +RTS -xc -RTS --dbgMsgSer --savePrefix test --newGame 9 --maxFps 60 --dumpInitRngs --automateAll --gameMode defense


play:
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --dumpInitRngs

frontendCampaign:
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --savePrefix test --newGame 1 --maxFps 60 --dumpInitRngs --automateAll --gameMode campaign

frontendRaid:
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --savePrefix test --newGame 5 --maxFps 60 --dumpInitRngs --automateAll --gameMode raid

frontendSkirmish:
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --savePrefix test --newGame 5 --maxFps 60 --dumpInitRngs --automateAll --gameMode skirmish

frontendAmbush:
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --savePrefix test --newGame 5 --maxFps 60 --dumpInitRngs --automateAll --gameMode ambush

frontendBattle:
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --savePrefix test --newGame 2 --maxFps 60 --dumpInitRngs --automateAll --gameMode battle

frontendBattleSurvival:
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --savePrefix test --newGame 8 --maxFps 60 --dumpInitRngs --automateAll --gameMode "battle survival"

frontendSafari:
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --savePrefix test --newGame 2 --maxFps 60 --dumpInitRngs --automateAll --gameMode safari

frontendSafariSurvival:
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --savePrefix test --newGame 8 --maxFps 60 --dumpInitRngs --automateAll --gameMode "safari survival"

frontendDefense:
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --savePrefix test --newGame 9 --maxFps 60 --dumpInitRngs --automateAll --gameMode defense

benchCampaign:
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --savePrefix test --newGame 1 --noDelay --noAnim --maxFps 100000 --frontendNull --benchmark --stopAfter 60 --automateAll --keepAutomated --gameMode campaign --setDungeonRng 42 --setMainRng 42 +RTS -N1 -RTS

benchBattle:
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --savePrefix test --newGame 2 --noDelay --noAnim --maxFps 100000 --frontendNull --benchmark --stopAfter 60 --automateAll --keepAutomated --gameMode battle --setDungeonRng 42 --setMainRng 42 +RTS -N1 -RTS

benchFrontendCampaign:
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --savePrefix test --newGame 1 --maxFps 100000 --benchmark --stopAfter 60 --automateAll --keepAutomated --gameMode campaign --setDungeonRng 42 --setMainRng 42 +RTS -N1 -RTS

benchFrontendBattle:
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --savePrefix test --newGame 2 --maxFps 100000 --benchmark --stopAfter 60 --automateAll --keepAutomated --gameMode battle --setDungeonRng 42 --setMainRng 42 +RTS -N1 -RTS

benchNull: benchCampaign benchBattle

bench: benchCampaign benchFrontendCampaign benchBattle benchFrontendBattle


test-travis-short: test-short

test-travis-medium: test-short test-medium

test-travis-medium-no-safari: test-short test-medium-no-safari

test-travis-long: test-short test-long

test-travis-long-no-safari: test-short test-long-no-safari

test: test-short test-medium test-long

test-short: test-short-new test-short-load

test-medium: testCampaign-medium testRaid-medium testSkirmish-medium testAmbush-medium testBattle-medium testBattleSurvival-medium testSafari-medium testSafariSurvival-medium testPvP-medium testCoop-medium testDefense-medium

test-medium-no-safari: testCampaign-medium testRaid-medium testSkirmish-medium testAmbush-medium testBattle-medium testBattleSurvival-medium testPvP-medium testCoop-medium testDefense-medium

test-long: testCampaign-long testRaid-medium testSkirmish-medium testAmbush-medium testBattle-long testBattleSurvival-long testSafari-long testSafariSurvival-long testPvP-medium testDefense-long

test-long-no-safari: testCampaign-long testRaid-medium testSkirmish-medium testAmbush-medium testBattle-long testBattleSurvival-long testPvP-medium testDefense-long

testCampaign-long:
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --savePrefix test --newGame 1 --noDelay --noAnim --maxFps 100000 --frontendStd --benchmark --stopAfter 500 --dumpInitRngs --automateAll --keepAutomated --gameMode campaign > /tmp/stdtest.log

testCampaign-medium:
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --savePrefix test --newGame 1 --noDelay --noAnim --maxFps 100000 --frontendStd --benchmark --stopAfter 400 --dumpInitRngs --automateAll --keepAutomated --gameMode campaign > /tmp/stdtest.log

testRaid-long:
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --savePrefix test --newGame 5 --maxFps 100000 --frontendStd --benchmark --stopAfter 60 --dumpInitRngs --automateAll --keepAutomated --gameMode raid > /tmp/stdtest.log

testRaid-medium:
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --savePrefix test --newGame 5 --maxFps 100000 --frontendStd --benchmark --stopAfter 30 --dumpInitRngs --automateAll --keepAutomated --gameMode raid > /tmp/stdtest.log

testSkirmish-long:
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --savePrefix test --newGame 5 --maxFps 100000 --frontendStd --benchmark --stopAfter 60 --dumpInitRngs --automateAll --keepAutomated --gameMode skirmish > /tmp/stdtest.log

testSkirmish-medium:
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --savePrefix test --newGame 5 --maxFps 100000 --frontendStd --benchmark --stopAfter 30 --dumpInitRngs --automateAll --keepAutomated --gameMode skirmish > /tmp/stdtest.log

testAmbush-long:
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --savePrefix test --newGame 5 --noDelay --noAnim --maxFps 100000 --frontendStd --benchmark --stopAfter 60 --dumpInitRngs --automateAll --keepAutomated --gameMode ambush > /tmp/stdtest.log

testAmbush-medium:
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --savePrefix test --newGame 5 --noDelay --noAnim --maxFps 100000 --frontendStd --benchmark --stopAfter 30 --dumpInitRngs --automateAll --keepAutomated --gameMode ambush > /tmp/stdtest.log

testBattle-long:
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --savePrefix test --newGame 2 --noDelay --noAnim --maxFps 100000 --frontendStd --benchmark --stopAfter 100 --dumpInitRngs --automateAll --keepAutomated --gameMode battle > /tmp/stdtest.log

testBattle-medium:
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --savePrefix test --newGame 2 --noDelay --noAnim --maxFps 100000 --frontendStd --benchmark --stopAfter 50 --dumpInitRngs --automateAll --keepAutomated --gameMode battle > /tmp/stdtest.log

testBattleSurvival-long:
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --savePrefix test --newGame 8 --noDelay --noAnim --maxFps 100000 --frontendStd --benchmark --stopAfter 100 --dumpInitRngs --automateAll --keepAutomated --gameMode "battle survival" > /tmp/stdtest.log

testBattleSurvival-medium:
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --savePrefix test --newGame 8 --noDelay --noAnim --maxFps 100000 --frontendStd --benchmark --stopAfter 50 --dumpInitRngs --automateAll --keepAutomated --gameMode "battle survival" > /tmp/stdtest.log

testSafari-long:
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --savePrefix test --newGame 2 --noDelay --noAnim --maxFps 100000 --frontendStd --benchmark --stopAfter 250 --dumpInitRngs --automateAll --keepAutomated --gameMode safari > /tmp/stdtest.log

testSafari-medium:
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --savePrefix test --newGame 2 --noDelay --noAnim --maxFps 100000 --frontendStd --benchmark --stopAfter 200 --dumpInitRngs --automateAll --keepAutomated --gameMode safari > /tmp/stdtest.log

testSafariSurvival-long:
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --savePrefix test --newGame 8 --noDelay --noAnim --maxFps 100000 --frontendStd --benchmark --stopAfter 250 --dumpInitRngs --automateAll --keepAutomated --gameMode "safari survival" > /tmp/stdtest.log

testSafariSurvival-medium:
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --savePrefix test --newGame 8 --noDelay --noAnim --maxFps 100000 --frontendStd --benchmark --stopAfter 200 --dumpInitRngs --automateAll --keepAutomated --gameMode "safari survival" > /tmp/stdtest.log


testPvP-long:
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --savePrefix test --newGame 5 --noDelay --noAnim --maxFps 100000 --frontendStd --benchmark --stopAfter 60 --dumpInitRngs --automateAll --keepAutomated --gameMode PvP > /tmp/stdtest.log

testPvP-medium:
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --savePrefix test --newGame 5 --noDelay --noAnim --maxFps 100000 --frontendStd --benchmark --stopAfter 30 --dumpInitRngs --automateAll --keepAutomated --gameMode PvP > /tmp/stdtest.log

testCoop-long:
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --savePrefix test --newGame 2 --noDelay --noAnim --maxFps 100000 --frontendStd --benchmark --stopAfter 500 --dumpInitRngs --automateAll --keepAutomated --gameMode Coop > /tmp/stdtest.log

testCoop-medium:
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --savePrefix test --newGame 2 --noDelay --noAnim --maxFps 100000 --frontendStd --benchmark --stopAfter 300 --dumpInitRngs --automateAll --keepAutomated --gameMode Coop > /tmp/stdtest.log

testDefense-long:
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --savePrefix test --newGame 9 --noDelay --noAnim --maxFps 100000 --frontendStd --benchmark --stopAfter 500 --dumpInitRngs --automateAll --keepAutomated --gameMode defense > /tmp/stdtest.log

testDefense-medium:
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --savePrefix test --newGame 9 --noDelay --noAnim --maxFps 100000 --frontendStd --benchmark --stopAfter 300 --dumpInitRngs --automateAll --keepAutomated --gameMode defense > /tmp/stdtest.log

test-short-new:
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --newGame 5 --savePrefix campaign --dumpInitRngs --automateAll --keepAutomated --gameMode campaign --frontendStd --stopAfter 2 > /tmp/stdtest.log
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --newGame 5 --savePrefix raid --dumpInitRngs --automateAll --keepAutomated --gameMode raid --frontendStd --stopAfter 2 > /tmp/stdtest.log
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --newGame 5 --savePrefix skirmish --dumpInitRngs --automateAll --keepAutomated --gameMode skirmish --frontendStd --stopAfter 2 > /tmp/stdtest.log
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --newGame 5 --savePrefix ambush --dumpInitRngs --automateAll --keepAutomated --gameMode ambush --frontendStd --stopAfter 2 > /tmp/stdtest.log
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --newGame 5 --savePrefix battle --dumpInitRngs --automateAll --keepAutomated --gameMode battle --frontendStd --stopAfter 2 > /tmp/stdtest.log
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --newGame 5 --savePrefix battleSurvival --dumpInitRngs --automateAll --keepAutomated --gameMode "battle survival" --frontendStd --stopAfter 2 > /tmp/stdtest.log
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --newGame 5 --savePrefix safari --dumpInitRngs --automateAll --keepAutomated --gameMode safari --frontendStd --stopAfter 2 > /tmp/stdtest.log
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --newGame 5 --savePrefix safariSurvival --dumpInitRngs --automateAll --keepAutomated --gameMode "safari survival" --frontendStd --stopAfter 2 > /tmp/stdtest.log
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --newGame 5 --savePrefix PvP --dumpInitRngs --automateAll --keepAutomated --gameMode PvP --frontendStd --stopAfter 2 > /tmp/stdtest.log
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --newGame 5 --savePrefix Coop --dumpInitRngs --automateAll --keepAutomated --gameMode Coop --frontendStd --stopAfter 2 > /tmp/stdtest.log
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --newGame 5 --savePrefix defense --dumpInitRngs --automateAll --keepAutomated --gameMode defense --frontendStd --stopAfter 2 > /tmp/stdtest.log

test-short-load:
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --savePrefix campaign --dumpInitRngs --automateAll --keepAutomated --gameMode campaign --frontendStd --stopAfter 2 > /tmp/stdtest.log
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --savePrefix raid --dumpInitRngs --automateAll --keepAutomated --gameMode raid --frontendStd --stopAfter 2 > /tmp/stdtest.log
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --savePrefix skirmish --dumpInitRngs --automateAll --keepAutomated --gameMode skirmish --frontendStd --stopAfter 2 > /tmp/stdtest.log
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --savePrefix ambush --dumpInitRngs --automateAll --keepAutomated --gameMode ambush --frontendStd --stopAfter 2 > /tmp/stdtest.log
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --savePrefix battle --dumpInitRngs --automateAll --keepAutomated --gameMode battle --frontendStd --stopAfter 2 > /tmp/stdtest.log
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --savePrefix battleSurvival --dumpInitRngs --automateAll --keepAutomated --gameMode "battle survival" --frontendStd --stopAfter 2 > /tmp/stdtest.log
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --savePrefix safari --dumpInitRngs --automateAll --keepAutomated --gameMode safari --frontendStd --stopAfter 2 > /tmp/stdtest.log
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --savePrefix safariSurvival --dumpInitRngs --automateAll --keepAutomated --gameMode "safari survival" --frontendStd --stopAfter 2 > /tmp/stdtest.log
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --savePrefix PvP --dumpInitRngs --automateAll --keepAutomated --gameMode PvP --frontendStd --stopAfter 2 > /tmp/stdtest.log
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --savePrefix Coop --dumpInitRngs --automateAll --keepAutomated --gameMode Coop --frontendStd --stopAfter 2 > /tmp/stdtest.log
	dist/build/SpacePrivateers/SpacePrivateers --dbgMsgSer --savePrefix defense --dumpInitRngs --automateAll --keepAutomated --gameMode defense --frontendStd --stopAfter 2 > /tmp/stdtest.log


build-binary:
	cabal configure -frelease --prefix=/
	cabal build SpacePrivateers
	rm -rf /tmp/SpacePrivateers_x_ubuntu-12.04-amd64.tar.gz
	rm -rf /tmp/SpacePrivateersGameInstall
	rm -rf /tmp/SpacePrivateersGame
	mkdir -p /tmp/SpacePrivateersGame/GameDefinition
	cabal copy --destdir=/tmp/SpacePrivateersGameInstall
	cp /tmp/SpacePrivateersGameInstall/bin/SpacePrivateers /tmp/SpacePrivateersGame
	cp GameDefinition/PLAYING.md /tmp/SpacePrivateersGame/GameDefinition
	cp GameDefinition/scores /tmp/SpacePrivateersGame/GameDefinition
	cp GameDefinition/config.ui.default /tmp/SpacePrivateersGame/GameDefinition
	cp CHANGELOG.md /tmp/SpacePrivateersGame
	cp CREDITS /tmp/SpacePrivateersGame
	cp LICENSE /tmp/SpacePrivateersGame
	cp README.md /tmp/SpacePrivateersGame
	tar -czf /tmp/SpacePrivateers_x_ubuntu-12.04-amd64.tar.gz -C /tmp SpacePrivateersGame

build-binary-i386:
	cabal configure -frelease --prefix=/ --ghc-option="-optc-m32" --ghc-option="-opta-m32" --ghc-option="-optl-m32" --ld-option="-melf_i386"
	cabal build SpacePrivateers
	rm -rf /tmp/SpacePrivateers_x_ubuntu-12.04-i386.tar.gz
	rm -rf /tmp/SpacePrivateersGameInstall
	rm -rf /tmp/SpacePrivateersGame
	mkdir -p /tmp/SpacePrivateersGame/GameDefinition
	cabal copy --destdir=/tmp/SpacePrivateersGameInstall
	cp /tmp/SpacePrivateersGameInstall/bin/SpacePrivateers /tmp/SpacePrivateersGame
	cp GameDefinition/PLAYING.md /tmp/SpacePrivateersGame/GameDefinition
	cp GameDefinition/scores /tmp/SpacePrivateersGame/GameDefinition
	cp GameDefinition/config.ui.default /tmp/SpacePrivateersGame/GameDefinition
	cp CHANGELOG.md /tmp/SpacePrivateersGame
	cp CREDITS /tmp/SpacePrivateersGame
	cp LICENSE /tmp/SpacePrivateersGame
	cp README.md /tmp/SpacePrivateersGame
	tar -czf /tmp/SpacePrivateers_x_ubuntu-12.04-i386.tar.gz -C /tmp SpacePrivateersGame

# TODO: figure out, whey this must be so different from Linux
build-binary-windows-i386:
	wine cabal configure -frelease
	wine cabal build exe:SpacePrivateers
	rm -rf /tmp/SpacePrivateers_x_windows-i386.zip
	rm -rf /tmp/SpacePrivateersGameInstall
	rm -rf /tmp/SpacePrivateersGame
	mkdir -p /tmp/SpacePrivateersGame/GameDefinition
	wine cabal copy --destdir=Z:/tmp/SpacePrivateersGameInstall
	cp /tmp/SpacePrivateersGameInstall/users/mikolaj/Application\ Data/cabal/bin/SpacePrivateers.exe /tmp/SpacePrivateersGame
	cp GameDefinition/PLAYING.md /tmp/SpacePrivateersGame/GameDefinition
	cp GameDefinition/scores /tmp/SpacePrivateersGame/GameDefinition
	cp GameDefinition/config.ui.default /tmp/SpacePrivateersGame/GameDefinition
	cp CHANGELOG.md /tmp/SpacePrivateersGame
	cp CREDITS /tmp/SpacePrivateersGame
	cp LICENSE /tmp/SpacePrivateersGame
	cp README.md /tmp/SpacePrivateersGame
	cp /home/mikolaj/.wine/drive_c/users/mikolaj/gtk/bin/zlib1.dll /tmp/SpacePrivateersGame
	wine Z:/home/mikolaj/.local/share/wineprefixes/7zip/drive_c/Program\ Files/7-Zip/7z.exe a -ssc -sfx Z:/tmp/SpacePrivateers_x_windows-i386.exe Z:/tmp/SpacePrivateersGame
