Date: Wed, 26 Apr 2000 22:05:56 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: "W. Taylor Holliday" <wtholliday@ucdavis.edu>
cc: daenzerm@student.ethz.ch, linuxppc-dev@lists.linuxppc.org
Subject: Re: XFree 4.0 dual monitor on AGP G4
In-Reply-To: <200004261951.MAA04687@pop3.ucdavis.edu>
Message-ID: <Pine.LNX.4.10.10004262157070.30596-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >> Unfortunately, the XFree86 4.0 docs say that PCI id's are mandatory for
> >> dual-head configs.
> >
> > So? You have specified them.
> >
>
> Well using fbdev in principle should be abstracted from pci hardware.

In principle. OTOH, the X server insists on examining the PCI config
regardless of the fbdev interface having everything set up OK. And the
fbdev driver currently does not provide a method to report the IO base for
the chipset registers. Neither does it provide a way for the X server to
associate a PCI device with a given framebuffer device to figure the
missing information from the PCI resources. You might argue that the X
server could reconstruct that association from the PCI resources and the
fb_info video mem address. Using the PCI resources for all purposes is
probably easier though.

> given what Kostas Gewrgiou told me regarding the fbdev_open_pci function,
> viewing logs isn't going to do me any good.

I've not seen fbdev_open_pci called (on the Mach64 driver, that is).

> oh, and probeonly crashes the machine :-(

Care to post a lspci -vv log?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
