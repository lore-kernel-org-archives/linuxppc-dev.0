Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Subject: Cross compiling : problem linking
From: Toni Van Remortel <t.vanremortel@ha.be>
Reply-To: linuxppc-embedded@lists.linuxppc.org
To: linuxppc-embedded@lists.linuxppc.org
Content-Type: text/plain
Message-Id: <1065099415.10206.5.camel@toni>
Mime-Version: 1.0
Date: Thu, 02 Oct 2003 14:56:56 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I try to cross compile a small test program for the EP505 board. I use
ELDK as compiler set.

When using this compile command:

ppc_4xx-gcc -O -v -nostdlib -nostartfiles -mno-eabi -fno-exceptions \
-fno-builtin -Wl,-Tscript.ld,-N -o rt_mod rt_mod.c

I get after a while:

/opt/eldk/usr/ppc-linux/bin/ld: cannot open linker script file \
script.ld: Onbekend bestand of map
collect2: ld returned 1 exit status

I don't know what is wrong, but 'script.ld' isn't anywhere on my system.

Side note: I used the compiler set already to cross compile a kernel,
XFree and FLTK, so it works.

Any idea?

PS: the program currently should make a square wave on EBC P1 D1
--
                           Toni Van Remortel
              Wetenschappelijk Medewerker - D-science lab
  Real time Linux for embedded systems: http://linemb.d-sciencelab.com
              Tel: +32 3 205 61 72 - Fax: +32 3 205 61 95
                      E-mail: t.vanremortel@ha.be


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
