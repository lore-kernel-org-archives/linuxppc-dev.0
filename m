Message-ID: <3AF8554D.BF250E0A@arlut.utexas.edu>
Date: Tue, 08 May 2001 15:21:33 -0500
From: Ken Offer <koffer@arlut.utexas.edu>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Problem with linuxppc smp.c
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

Compiling the latest-greatest linuxppc 2.4.5 from
www.fsmlabs.com/linuxppcbk.html yields the following compile-time errors
in arch/ppc/kernel/smp.c:

gcc -D__KERNEL__ -I/usr/src/linuxppc_2_4_5/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing
-D__powerpc__ -
fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple
-mstring    -c -o smp.o smp.c
smp.c: In function `smp_gemini_kick_cpu':
smp.c:670: `i' undeclared (first use in this function)
smp.c:670: (Each undeclared identifier is reported only once
smp.c:670: for each function it appears in.)
smp.c: In function `smp_gemini_setup_cpu':
smp.c:679: `cpu_nr' undeclared (first use in this function)
smp.c: At top level:
smp.c:748: warning: initialization from incompatible pointer type
make[1]: *** [smp.o] Error 1
make[1]: Leaving directory `/usr/src/linuxppc_2_4_5/arch/ppc/kernel'
make: *** [_dir_arch/ppc/kernel] Error 2

I'm compiling the 2.4.5 kernel on a synergy VSS4 board using gcc-2.95.3
and binutils-2.11.90.0.7 installed.  The machine-type is configured as
"gemini", since I'm on the VSS4.

Any thoughts?  I guess I could try to grok the author's meaning and fix
this... ;-)

--
______________________________________________________________
Kenneth Ray Offer, II
Sr. Systems Analyst
Applied Research Laboratories/SDD
University of Texas at Austin
Office (512) 835-3859   FAX (512) 835-3259

Any opinions expressed above are mine and not necessarily
those of my employer.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
