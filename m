Message-ID: <3BCC3EEE.35029A2F@midrivers.com>
Date: Tue, 16 Oct 2001 08:06:38 -0600
From: Mark Pilon <mpilon@midrivers.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: libc not finding atexit() w/ -lm
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


all,

I'm attempting to link a .o containing the whetstone benchmark
to a package of stand-alone (runs pre-linux) diags and, depending
where in LD's args I stick -lm:

whetstone.o: In function `whetstone_main':
whetstone.o(.text+0x414): undefined reference to `sin'
whetstone.o(.text+0x420): undefined reference to `cos'
whetstone.o(.text+0x434): undefined reference to `cos'
.
.
.

OR,

/home/mpilon/ppc_tools/ppc_home/powerpc-linux/lib/libc.so.6: undefined
reference to `atexit'
make[1]: *** [mercury] Error 1
make[1]: Leaving directory `/home/mpilon/mercury/diagboot'

-- I suspect I'd get the latter error if I fixed the first.

I built my own tools so I suspect a path problem or lack of a patch;
I searched the linuxppc-embedded list but found nothing for 'atexit'

all help appreciated,

Mark
--
Mark Pilon

Minolta-QMS
P.O. Box 37
Fallon, MT.  59326-0037

1-406-853-0433

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
