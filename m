Mime-Version: 1.0
Message-Id: <a04310101b8e0b0f04111@[199.170.89.178]>
In-Reply-To: <20020415050103.6412@mailhost.mipsys.com>
References: <a04310102b8e086debdbe@[199.170.89.178]>
 <20020415050103.6412@mailhost.mipsys.com>
Date: Mon, 15 Apr 2002 11:48:55 -0500
To: linuxppc-dev@lists.linuxppc.org
From: Jeff Walther <trag@io.com>
Subject: PPB Bug in PowerSurge:  was: 9600 maturity
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 06:01 +0100 04/15/2002, benh@kernel.crashing.org wrote:

>>I have found that any PCI card which has its own PPB hangs the
>>machine (with a few exceptions) in the lower four slots.  i.e. if you
>>create a hierarchy of two PPBs Apple's PCI implementation bails.
>>
>>Jeff Walther
>
>Yes, this is a known bug of older OFs, though an OF patch is floating
>around to fix it (dunno how to find it though).
>
>Note that recent 2.4 kernels may be able to work around OF bugs here.

Thank you for that information, Ben.  I'm really more of a MacOS guy
and subscribed to these lists out of an interest in low level
hardware issues.  There doesn't seem to be any other forum that
discusses hardware specifically, so you guys (and other Linux/Darwin
lists) who sometimes must program to the hardware are the next best
thing.

Do you have suggestions on where I might begin a hunt for such an OF
patch?  I assume this is something that one could load in NVRAM under
any OS that will take care of the bug until the next time the NVRAM
is reset?

There is an email list (SuperMacs) at lowendmac.com of Umax users and
this is an issue that has been a big pain for most of us because our
lower four slots are behind one PPB.  Any device that adds another
creates a problem.    It became especially acute with the
introduction of the FW/USB cards.

I didn't know it was an Apple bug when I first ran into the problem
and figured it could be a problem with OF or the Bandit or the DEC
21052 chip.  So I replaced the DEC 21052 with the Intel 21152AB, the
Intel 21152BA, the TI PCI2550, and the Hint HB1-SE33P.  After all
those PPBs had the same symptoms I was convinced it was an Apple
problem.  I was willing to entertain the notion that all the older
PPBs might have the same bug, especially because the Intel is the
descendant of the DEC, but the Hint is a relatively new design.

If someone knows how to patch the OF in the ROM for the PowerSurge I
can get the patched ROM code written into Flash Memory chips that are
pin compatible with the Mask ROMs on the PowerSurge machines.  If
anyone is actually interested in this, it would probably be best to
use the Kansas ROM code as the base.  I've but Kansas ROMs in the
clones (Umax and PCC PTP) and in 7500/8500 machines and it works fine
and eliminates the speculative processing issue with G3 processors.
The Kansas ROM works with any PowerSurge machine as far as I can
tell.  Unfortunately, it doesn't solve the PPB problem.  :-(

Jeff Walther

P.S.  Apologies for veering off topic for the list.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
