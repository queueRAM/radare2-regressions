VERSION=1.4.0-git
DESTDIR?=/
PREFIX?=/usr/local
BINDIR=$(DESTDIR)/$(PREFIX)/bin
PWD=$(shell pwd)
PKG=radare2-regressions
TAR=tar -cvf
TAREXT=tar.xz
CZ=xz -f

TDIRS=$(shell ls -d t*| grep -v tmp) bins
LIBDIR=$(DESTDIR)/$(PREFIX)/lib

-include config.mk


PULLADDR=https://github.com/radare/radare2-regressions.git

do:
	-git pull ${PULLADDR}
	-$(MAKE) overlay-apply
	$(SHELL) run_tests.sh

overlay:
	if [ -f ../t/overlay ]; then \
		$(SHELL) overlay.sh create ; \
	fi

apply-overlay overlay-apply:
	$(SHELL) overlay.sh apply

all:
	-$(MAKE) overlay-apply
	$(MAKE) alltargets

alltargets: radare2 commands formats tools io asm anal esil tools archos

radare2:
	@if [ -f ../binr/radare2/radare2 ]; then $(SHELL) run_tests.sh ../t ; fi

archos:
	@$(MAKE) -C t.archos
dbg.linux:
	$(SHELL) run_tests.sh t.archos/Linux

commands:
	$(SHELL) run_tests.sh

java: asm.java anal.java format.java

tools:
	$(SHELL) run_tests.sh t.tools

io:
	$(SHELL) run_tests.sh t.io

asm: asm.8051 asm.arc asm.arm asm.avr asm.cr16 asm.dalvik asm.ebc asm.gb asm.h8300 asm.labels asm.lh5801 asm.java asm.mips asm.msp430	asm.tms320 asm.ws asm.x86 asm.z80 asm.pic18c asm.m68k asm.wasm
asm.8051:
	$(SHELL) run_tests.sh t.asm/8051
asm.arc:
	$(SHELL) run_tests.sh t.asm/arc
asm.arm:
	$(SHELL) run_tests.sh t.asm/arm
asm.avr:
	$(SHELL) run_tests.sh t.asm/avr
asm.cr16:
	$(SHELL) run_tests.sh t.asm/cr16
asm.dalvik:
	$(SHELL) run_tests.sh t.asm/dalvik
asm.ebc:
	$(SHELL) run_tests.sh t.asm/ebc
asm.gb:
	$(SHELL) run_tests.sh t.asm/gb
asm.h8300:
	$(SHELL) run_tests.sh t.asm/h8300
asm.java:
	$(SHELL) run_tests.sh t.asm/java
asm.labels:
	$(SHELL) run_tests.sh t.asm/labels
asm.lh5801:
	$(SHELL) run_tests.sh t.asm/lh5801
asm.mips:
	$(SHELL) run_tests.sh t.asm/mips
asm.msp430:
	$(SHELL) run_tests.sh t.asm/msp430
asm.tms320:
	$(SHELL) run_tests.sh t.asm/tms320
asm.v810:
	$(SHELL) run_tests.sh t.asm/v810
asm.ws:
	$(SHELL) run_tests.sh t.asm/ws
asm.x86:
	$(SHELL) run_tests.sh t.asm/x86
asm.z80:
	$(SHELL) run_tests.sh t.asm/z80
asm.pic18c:
	$(SHELL) run_tests.sh t.asm/pic18c
asm.m68k:
	$(SHELL) run_tests.sh t.asm/m68k
asm.wasm:
	$(SHELL) run_tests.sh t.asm/wasm

anal: anal.arc anal.arm anal.avr anal.dalvik anal.java anal.mips anal.x86 anal.others anal.6502
anal.arc:
	$(SHELL) run_tests.sh t.anal/arc
anal.arm:
	$(SHELL) run_tests.sh t.anal/arm
anal.avr:
	$(SHELL) run_tests.sh t.anal/avr
anal.dalvik:
	$(SHELL) run_tests.sh t.anal/dalvik
anal.java:
	$(SHELL) run_tests.sh t.anal/java
anal.mips:
	$(SHELL) run_tests.sh t.anal/mips
anal.x86:
	$(SHELL) run_tests.sh t.anal/x86
anal.others:
	$(SHELL) run_tests.sh t.anal/others_anal
anal.6502:
	$(SHELL) run_tests.sh t.anal/6502

esil:
	$(SHELL) run_tests.sh t.esil

formats: format.bflt format.coff format.smd format.vsf format.dex format.elf format.firmware format.java format.mach0 format.mangling format.msil format.omf format.others format.pdb format.pe format.xbe format.zimg format.nes format.gba format.wasm
format.vsf:
	$(SHELL) run_tests.sh t.formats/vsf
format.smd:
	$(SHELL) run_tests.sh t.formats/smd
format.coff:
	$(SHELL) run_tests.sh t.formats/coff
format.bflt:
	$(SHELL) run_tests.sh t.formats/bflt
format.dex:
	$(SHELL) run_tests.sh t.formats/dex
format.elf:
	$(SHELL) run_tests.sh t.formats/elf
format.firmware:
	$(SHELL) run_tests.sh t.formats/firmware
format.java:
	$(SHELL) run_tests.sh t.formats/java
format.mach0:
	$(SHELL) run_tests.sh t.formats/mach0
format.mangling:
	$(SHELL) run_tests.sh t.formats/mangling
format.msil:
	$(SHELL) run_tests.sh t.formats/msil
format.omf:
	$(SHELL) run_tests.sh t.formats/omf
format.others:
	$(SHELL) run_tests.sh t.formats/others
format.pdb:
	$(SHELL) run_tests.sh t.formats/pdb
format.pe:
	$(SHELL) run_tests.sh t.formats/pe
format.xbe:
	$(SHELL) run_tests.sh t.formats/xbe
format.zimg:
	$(SHELL) run_tests.sh t.formats/zimg
format.nes:
	$(SHELL) run_tests.sh t.formats/nes
format.gba:
	$(SHELL) run_tests.sh t.formats/gba
format.wasm:
	$(SHELL) run_tests.sh t.formats/wasm


tools: rabin2 radiff2 ragg2 ragg2-cc rahash2 rasm2 rax2 r2
rabin2:
	$(SHELL) run_tests.sh t.tools/rabin2
radiff2:
	$(SHELL) run_tests.sh t.tools/radiff2
ragg2:
	$(SHELL) run_tests.sh t.tools/ragg2
ragg2-cc:
	$(SHELL) run_tests.sh t.tools/ragg2-cc
rahash2:
	$(SHELL) run_tests.sh t.tools/rahash2
rasm2:
	$(SHELL) run_tests.sh t.tools/rasm2
rax2:
	$(SHELL) run_tests.sh t.tools/rax2
r2:
	$(SHELL) run_tests.sh t.tools/r2

keystone:
	$(SHELL) run_tests.sh t.extras/keystone

swf:
	$(SHELL) run_tests.sh t.extras/swf

m68k-extras:
	$(SHELL) run_tests.sh t.extras/m68k

extras.mdmp:
	$(SHELL) run_tests.sh t.extras/mdmp

olly-extras:
	$(SHELL) run_tests.sh t.extras/x86_olly

dwarf:
	$(SHELL) run_tests.sh t.extras/dwarf

broken:
	grep BROKEN=1 t -r -l

clean:
	rm -rf tmp

symstall:
	chmod +x r2-v r2r
	ln -fs $(PWD)/r2-v $(BINDIR)/r2-v
	ln -fs $(PWD)/r2r $(BINDIR)/r2r

#sed -e 's,@R2RDIR@,$(PWD),g' < $(PWD)/r2-v > $(BINDIR)/r2-v
#sed -e 's,@R2RDIR@,$(PWD),g' < $(PWD)/r2r > $(BINDIR)/r2r
install:
	mkdir -p $(BINDIR)
	sed -e 's,@R2RDIR@,$(LIBDIR)/radare2-regressions,g' < $(PWD)/r2-v > $(BINDIR)/r2-v
	sed -e 's,@R2RDIR@,$(LIBDIR)/radare2-regressions,g' < $(PWD)/r2r > $(BINDIR)/r2r
	chmod +x $(BINDIR)/r2-v
	chmod +x $(BINDIR)/r2r
	mkdir -p $(LIBDIR)/radare2-regressions
	cp -rf $(TDIRS) $(LIBDIR)/radare2-regressions
	cp -rf *.sh $(LIBDIR)/radare2-regressions

uninstall:
	rm -f $(BINDIR)/r2r
	rm -f $(BINDIR)/r2-v
	rm -rf $(LIBDIR)/radare2-regressions

unit_tests:
	@make -C ./unit all
	@./run_unit.sh

tested:
	@grep -re FILE= t*  | cut -d : -f 2- | sed -e 's/^.*bins\///g' |sort -u | grep -v FILE

untested:
	@${MAKE} -s tested > .a
	@${MAKE} -s allbins > .b
	@diff -ru .a .b | grep ^+ | grep -v +++ | cut -c 2-
	@rm -f .a .b

allbins:
	find bins -type f

dist:
	git clone . $(PKG)-$(VERSION)
	rm -rf $(PKG)-$(VERSION)/.git
	$(TAR) "$(PKG)-${VERSION}.tar" "$(PKG)-$(VERSION)"
	${CZ} "$(PKG)-${VERSION}.tar"

.PHONY: all clean allbins dist
