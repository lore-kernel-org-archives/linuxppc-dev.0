Message-Id: <200112042332.SAA17067@missioncriticallinux.com>
From: mod+linuxppc-dev@MissionCriticalLinux.com
To: linuxppc-dev@lists.linuxppc.org
Subject: Status of linuxppc support for Galileo GT64260
Date: Tue, 04 Dec 2001 18:32:12 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm working with older linuxppc sources
that run on a box designed around
the Galileo GT64260 and I'm thinking
about merging forward to the current
linuxppc code base, so I'm wondering:
what's the current status of the code
that got checked in as the official
PPClinux code for the Galileo GT64260?

I'm asking because I recall seeing
messages on these lists saying that
code had been checked in with interrupt
problems, PCI problems, no integrated-Enet
driver and generally in "needs work"
condition.  I notice that there is now a
(strangely familiar) driver included for
the integrated Enet, but (except for the
recent exchange about how the GT64260 and
VT82C686B don't play so nice together) I
don't find much 64260-related discussion
here except one terse followup message
stating that PCI works.

So, is anybody using the current code?
Would I be wrong to interpret the fact
that it wouldn't compile when I tried it
today as indication that not much has
happened since the initial checkin by
MontaVista?  Are the interrupt problems
alluded to at the time of that initial
checkin (could somebody characterize
them for me?) still an issue?  Does
the PCI support seem solid?  Anything
in particular I need to watch out for?

Thanks.
          Michael O'Donnell
        Mission Critical Linux


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
