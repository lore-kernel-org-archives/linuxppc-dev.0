Message-ID: <3CB7708E.63151603@carts.com>
Date: Fri, 12 Apr 2002 16:41:02 -0700
From: Kevin Fry <kevin@carts.com>
MIME-Version: 1.0
To: linuxppc emb3dd3d list <linuxppc-embedded@lists.linuxppc.org>
Subject: Variable name inconsistancies / resources on building patches
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Looking at 2.4.18, I see that the the variable in immap_8260.h  for the
SCC's Protocol-Specific Mode Register is called the scc_pmsr. All the
#defines for it are called SCC_PMSR_blah.

As you can see someone called it the pmsr instead of the psmr which it
should be. All of the code for the FCC's uses the correct acronym
however..

The code I look at and compile all uses the correct (incorrect) name for
the SCC PSMR, so should we bother to write a patch to fix this?  I'm
inclined to say yes, only because it's frustrating to me to program
drivers and such with incorrect names :)

Since this would be my first kernel patch, are there any resources on
how to build patches and against what, and who to submit em
too??? thanks!

Kevin Fry


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
