Date: Fri, 12 May 2000 08:37:05 +0200 (MET DST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: compile problem with current bk tree
Message-ID: <Pine.GSO.4.10.10005120835040.2055-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


| make[2]: Entering directory `/extra/tmp/linuxppc_2_3/kernel'
| gcc -D__KERNEL__ -I/extra/tmp/linuxppc_2_3/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -DEXPORT_SYMTAB -c signal.c
| signal.c: In function `do_sigaction':
| signal.c:915: fixed or forbidden register 68 (0) was spilled for class CR0_REGS.This may be due to a compiler bug or to impossible asm statements or clauses.
| cpp: output pipe has been closed

| ccallisto$ gcc -v
| Reading specs from /usr/lib/gcc-lib/powerpc-linux/egcs-2.91.66/specs
| gcc version egcs-2.91.66 Debian GNU/Linux (egcs-1.1.2 release)
| callisto$

Any suggestions?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
