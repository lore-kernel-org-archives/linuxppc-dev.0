Message-Id: <l03130302b6e460bd2e0b@[24.218.240.205]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 25 Mar 2001 22:09:15 -0500
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
From: "Michael R. Zucca" <mrz5149@acm.org>
Subject: Sound stoppage
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm having a problem with sound stopping when I'm trying to use it at the
same time as X.

Machine lowdown:
PowerCenter 132 with a Sonnet 750 upgrade.
Adaptec Narrow Ultra SCSI PCI card.
XCLAIM VR Rage PRO PCI card (_not_ a VR128)

The problem occurs both with the 2.2.18 kernel that comes with the last
stable LinuxPPC install and with the most recent 2.2 snapshot that I could
get my hands on (sometime around last week). X is the stock XF68 that comes
with LinuxPPC (3.3.6 I think?)

I notice that I can play audio using XMMS or plaympeg but the sound stops
after a little while. I can force the stoppage to happen sooner when I drag
an opaque window around a lot so I think it has something to do with
generating heavy PCI traffic.

The stoppage seems to be screwing up the driver because the application
playing the sound is usually locked up pretty hard but the rest of the
processes keep running just fine. Perhaps we're dropping an interrupt
somewhere and the driver's stuck waiting?

Thanks!


____________________________________________________________________
 Michael Zucca - mrz5149@acm.org - http://www.mdc.net/~mrz5149/
 "I will choose a path that's clear. I will choose Freewill. "
  --Rush, Freewill
____________________________________________________________________


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
