From: mark@sps.la.asu.edu
Subject: Porting linux ppc to new platform
To: linuxppc-embedded@lists.linuxppc.org
Date: Sun, 23 Jul 2000 20:12:13 -0700 (MST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E13GYf7-0000Lz-00@sps.la.asu.edu>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


  Hello,

  I apologize if there is a FAQ for this loaded question, but I did not
immediately see one.


  I have been playing with linux for about 5 years and playing with the
kernel for about 1, but only on x86.


  Recently I have begun working with ppc and have ported vxWorks to our
platform and am now interested in porting linux.  I have gotten the RPX
lite board to boot, but then I really did not have to do anywork.

  What I'm intrested in is others who have ported linux to embedded platforms
so that I might ask them the amount of work invovled and where is a good
place to begin.  This will be on a board with no available firmware or drivers,
although I can perform enough low level configuration to bring up vxWorks.

  Is there specific memory layout required, what types of cpnfiguration is
neccessary at the hardware layer (immr, sypcr, icdct, mamr level stuff, etc.).
What do I need to do vs. what is done in the ppc kernel after it is capable
enough to load a C program.  Is there a powerpc equivalent to lilo,
or is this even needed.  Can I just jump to main.c?

  I have many more questions, but if these aqre answered by a FAQ I'll hold off until I can investigate more.

Thank you

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
