Message-ID: <397ED8AB.678FB32E@francetelecom.fr>
Date: Wed, 26 Jul 2000 14:25:15 +0200
From: FASSINO Jean-Philippe <jeanphilippe.fassino@francetelecom.fr>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: RTAS on PowerMac Newworld
References: <Pine.LNX.4.10.10007252036280.1490-100000@cassiopeia.home>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:

> On Tue, 25 Jul 2000, FASSINO Jean-Philippe wrote:
> > Benjamin Herrenschmidt wrote:
> > > >In the kernel for PPC, a lot a code is here just to do what doing RTAS :
> > > >pci config,
> > > >via (CUDA and PMU) (no need if no ADB keyboard), ...
> > > >When doing embedded systems, this drivers is very big and can be saving by
> > > >using
> > > >RTAS which i think is a very good thing in  CHRP specification. It's
> > > >strange that
> > > >apple do not provide it fully.
> > >
> > > Well, they didn't care about it. Note that Macs are far from beeing
> > > embedded boxes ;)
> >
> > Yes, but i'm using embedded term for small system that doing dedicate task
> > and only one (for example firewall, gateway, ... in only 50-100k kernel size).
> >
> > I'm actually experienced that with G4 with 4 network card.
>
> And what's the smallest amount of memory you can put in a G4? I guess it's an
> order of magnitude larger than a kernel containing all possible drivers :-)

Sure, but G4 is just a good computer for experimentation !

JP


--
--------------------------------------------------------------------------
 Jean-Philippe FASSINO              France Telecom R&D : DTL/ASR
 Tel : 04 76 76 45 52
 mailto:jeanphilippe.fassino@francetelecom.fr
--------------------------------------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
