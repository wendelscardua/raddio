PROJECT=raddio
LD65_FLAGS=
CA65_FLAGS=
NSF2DATA=/mnt/c/NESDev/famitone2d/NSF/nsf2data.exe
FAMITRACKER=/mnt/c/NESDev/famitracker/FamiTracker.exe
TARGET=${PROJECT}.nes

.PHONY : debug run

default: ${TARGET}

${TARGET}: src/${PROJECT}.o src/reset.o src/readjoy.o src/unrle.o src/audio-data.o
	ld65 $^ -t nes -o ${TARGET} ${LD65_FLAGS}

debug: LD65_FLAGS += -Ln labels.txt --dbgfile ${PROJECT}.nes.dbg
debug: CA65_FLAGS += -g -DDEBUG=1
debug: ${TARGET}

src/${PROJECT}.o: src/${PROJECT}.s $(shell find assets -type f)
	ca65 src/${PROJECT}.s ${CA65_FLAGS}

src/audio-data.o: src/audio-data.s assets/audio/${PROJECT}-sfx.s assets/audio/${PROJECT}-soundtrack.s
	ca65 src/audio-data.s ${CA65_FLAGS}

assets/audio/${PROJECT}-sfx.nsf: assets/audio/${PROJECT}-sfx.ftm
	${FAMITRACKER} assets/audio/${PROJECT}-sfx.ftm -export assets/audio/${PROJECT}-sfx.nsf

assets/audio/${PROJECT}-sfx.s: assets/audio/${PROJECT}-sfx.nsf
	${NSF2DATA} assets/audio/${PROJECT}-sfx.nsf -ca65 -ntsc

%.o: %.s
	ca65 $< ${CA65_FLAGS}

clean:
	rm src/*.o *.nes labels.txt *.dbg

run: debug
	Nintendulator.exe `wslpath -w -a ${PROJECT}.nes`