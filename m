Message-ID: <3903A49C.B0BB90EB@embeddededge.com>
Date: Sun, 23 Apr 2000 21:34:20 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: feature_init
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


OK.  I did it.  The feature_init call in setup.c is only relevant to OF
machines, so I put a CONFIG_ALL_PPC around it.  Then it hit me (it
hasn't happened in a while :-)........Does this mean CONFIG_PREP,
CONFIG_CHRP, CONFIG_PMAC are becoming obsolete?  They seem to be
combined now.  Maybe this is why I can't build a kernel for my Macs
because I still select PowerMac instead of "all PPC"?

Guess I'll go chase some Easter Bunnies......


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
