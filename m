Date: Mon, 27 Mar 2000 11:43:21 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Michel Dänzer <michdaen@iiic.ethz.ch>
cc: linuxppc-dev@lists.linuxppc.org, Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: LongTrail PCI resource assignment
In-Reply-To: <38DDD12E.43809311@iiic.ethz.ch>
Message-ID: <Pine.LNX.4.10.10003271059530.31313-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > I've seen a device option "UseFBDev" in XF86Config. I take that to mean
> > XFree knows a particular device (even with it's BusID specified) is going
> > to be handled by a framebuffer driver.
>
> No. The option is in the Device Section and thus driver-dependant. It just
> tells the driver to use fbdev for mode setting/switching etc. instead of
> banging the hardware directly. The option can be there but not the fbdev, the
> driver should then just fall back to banging.

OK, that explains this option. I've looked for a XConfig man page in the
source without success, and I have a few more

> If you can't fix/work around it yourself, you could post your ideas to
> devel@XFree86.Org (state clearly that you're not on the list as the reply-to
> is set to it) and in particular to Egbert Eich
> <eich@hilbert.ikp.physik.tu-darmstadt.de>

The PCI stuff is sorted by Geert's PCI patch. I'll post a fix for 2.2.15
shortly. The remaining trouble is with 16 and 32 bpp support which may be
a problem with atyfb as well. If it's a X problem the xfree people will
hear about it.

> Nothing will ever happen if you're complaining about X on linuxppc-dev.

Well, as you will have noticed, various people here helped pushing me in
the right direction (fixing the PCI conflicts in the kernel). I doubt the
xfree list would have been the place to ask PPC kernel questions.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
