Message-Id: <l03130300b7888b7385f8@[192.168.1.2]>
In-Reply-To: <20010727194525.345C0DBB0C@atlas.valhalla.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sat, 28 Jul 2001 11:35:12 -0400
To: "Iain Sandoe" <iain@sandoe.co.uk>
From: "Michael R. Zucca" <mrz5149@acm.org>
Subject: Re: [dmasound] Power Computing DEAD dbdma fix (finally)
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hats off to Iain for fixing this bug!

The fix can't be understated. I noticed that when this patch wasn't fixed,
the DEAD dbdma engine was somehow messing with PCI bus data. I noticed this
under X when I was using sound, there was garbage in some of the pixmaps
and scrolled regions. After the patch, X runs fine. This sort of corruption
behavior would be disasterous on something like a PCI disk controller.

So I ask that anybody currently maintaining a device which uses the DBDMA
engine to check your code and see if it deals with the DEAD status properly.

Thanks folks!

____________________________________________________________________
 Michael Zucca - mrz5149@acm.org - http://www.mdc.net/~mrz5149/
 "I will choose a path that's clear. I will choose Freewill. "
  --Rush, Freewill
____________________________________________________________________


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
