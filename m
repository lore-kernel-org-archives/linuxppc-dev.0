Message-Id: <l03130301b7834a2e6ea3@[192.168.1.100]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 24 Jul 2001 11:58:38 -0400
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
From: "Michael R. Zucca" <mrz5149@acm.org>
Subject: Sound stoppage on PowerCenter 132
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ok, it's been a long time since I last posted. I've been busy :-)

I rsync'd the benh-2.4 tree from 7/24 and compiled it. I checked the awacs
driver and it seems to contain the code which handles the DMA DEAD
condition.

The problem still seems to be the same. If I play an mp3 using mpg123, the
song plays fine. However, if I introduce enough PCI traffic (like, say,
opening up Netscape in X for my ATI PCI video card), the song stops dead
(no sound) but the mpg123 seems to stick around, presumably waiting on the
device.

The code "seems" more robust under X but that could just be my imagination. :-)

BTW, I have a PowerCenter 132 with a 750 upgrade in it, if that makes any
difference.

Thanks.

____________________________________________________________________
 Michael Zucca - mrz5149@acm.org - http://www.mdc.net/~mrz5149/
 "I will choose a path that's clear. I will choose Freewill. "
  --Rush, Freewill
____________________________________________________________________


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
