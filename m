Message-ID: <38DF4591.4B76CB99@iiic.ethz.ch>
Date: Mon, 27 Mar 2000 13:27:13 +0200
From: Michel Dänzer <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
CC: linuxppc-dev@lists.linuxppc.org, Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: LongTrail PCI resource assignment
References: <Pine.LNX.4.10.10003271059530.31313-100000@opal.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz wrote:
>
> > > I've seen a device option "UseFBDev" in XF86Config. I take that to mean
> > > XFree knows a particular device (even with it's BusID specified) is
> > > going to be handled by a framebuffer driver.
> >
> > No. The option is in the Device Section and thus driver-dependant. It just
> > tells the driver to use fbdev for mode setting/switching etc. instead of
> > banging the hardware directly. The option can be there but not the fbdev, > > the driver should then just fall back to banging.
>
> OK, that explains this option. I've looked for a XConfig man page in the
> source without success, and I have a few more

Documentation is somewhat lacking yet in 4.0 ... I'm glad to answer whatever I
can.


> > Nothing will ever happen if you're complaining about X on linuxppc-dev.
>
> Well, as you will have noticed, various people here helped pushing me in
> the right direction (fixing the PCI conflicts in the kernel). I doubt the
> xfree list would have been the place to ask PPC kernel questions.

Of course not. But you were talking about shortcomings in X, which probably
wouldn't get fixed if they were reported only here.


Michel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
