Message-ID: <391BBCCA.46B3ED69@pop.agri.ch>
Date: Fri, 12 May 2000 10:11:54 +0200
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: a.tobler@schweiz.ch
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: compile problem with current bk tree
References: <Pine.GSO.4.10.10005120835040.2055-100000@dandelion.sonytel.be>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:
>
> | make[2]: Entering directory `/extra/tmp/linuxppc_2_3/kernel'
> | gcc -D__KERNEL__ -I/extra/tmp/linuxppc_2_3/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -DEXPORT_SYMTAB -c signal.c
> | signal.c: In function `do_sigaction':
> | signal.c:915: fixed or forbidden register 68 (0) was spilled for class CR0_REGS.This may be due to a compiler bug or to impossible asm statements or clauses.
> | cpp: output pipe has been closed
>
> | ccallisto$ gcc -v
> | Reading specs from /usr/lib/gcc-lib/powerpc-linux/egcs-2.91.66/specs
> | gcc version egcs-2.91.66 Debian GNU/Linux (egcs-1.1.2 release)
> | callisto$
>
> Any suggestions?
Don't see it here, though I'm not sure if I'm up to date with bk-devel.
I rsynced it a few minutes ago. I gave up direct bk access since it eats
my hd, for each branch I need 300MB at least!!
The only difference I see, I use a gcc-2.95.2 19991024 from Franz.

Andreas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
