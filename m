Date: Wed, 27 Oct 1999 21:06:49 +0000 (   )
From: John Buswell <johnb@one.net>
To: Hollis R Blanchard <hollis@andrew.cmu.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: iMac DV and BootX
In-Reply-To: <38176697.54C0E851@andrew.cmu.edu>
Message-ID: <Pine.LNX.3.96.991027210159.25681I-100000@shell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 27 Oct 1999, Hollis R Blanchard wrote:

> Well, there's some bad news... the new iMac, the iBook, and the Sawtooth
> G4's cannot currently run Linux.

afaik. BenH has got the iBook to boot.

> Of course, if you're curious you might try out the iBook kernel from
> http://calvaweb.calvacom.fr/bh40/test.html. It would be interesting to
> see how far it gets on an iMac DV.

a few steps ahead of you here :) I've been messing with Ben's patches,
various kernels and different BootX/MacOS configurations on the iMac DV.
The problem appears to be that the iMac is not getting past the first
stage of the BootX boot. I ran bootx 1.2b in debug mode and it gets as far
as blanking the screen, on a rev.b imac this then throws up the booting
message, debug info and continues with the boot. Even without proper
kernel support, with video=ofonly the thing should boot with at least the
booting message before dying, this just blanks screen, hdd powers down (or
at least sounds like that). Now the iMac (first generation) without video=
or no video driver ticked in bootX would give a blank screen and power
down the monitor, but would still boot (you'd just be blind) :) this isn't
doing that.. just blank screen.. which (after a few days) has lead me to
think it might have something to do with something lacking or needing to
be changed in BootX.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
