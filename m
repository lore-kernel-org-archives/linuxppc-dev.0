Date: Wed, 29 Mar 2000 12:06:00 +0300 (EEST)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
cc: michdaen@iiic.ethz.ch, "William H. Schultz" <whschult@uncc.edu>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: XFree86 4.0 working as fbdev on Voodoo3
In-Reply-To: <Pine.LNX.4.10.10003282253070.7557-100000@opal.biophys.uni-duesseldorf.de>
Message-ID: <Pine.LNX.4.21.0003291114060.1371-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 28 Mar 2000, Michael Schmitz wrote:

>
> > > Doesn't the tdfx driver work?
> > >
> >
> >   Beyond endianess problems the tdfx driver uses PIO which isn't
> > working under ppc right now (and unless the kernel people decide
> > on a way to export iobase to userland some time soon PIO might
> > take a while until it gets supported)
>
> Can't we use the MMIO aperture to access the PIO registers?
>

  Most of the PIO registers are available under MMIO as well,
unfortunately the crtc registers (and a few others) are only
available in the PIO aperture :(

  Kostas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
