Message-ID: <3A9CF2B3.9FACDA6A@ipno.in2p3.fr>
Date: Wed, 28 Feb 2001 13:44:35 +0100
From: xav <grave@ipno.in2p3.fr>
MIME-Version: 1.0
To: Matt Porter <mporter@mvista.com>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>, paubert@iram.es
Subject: Re: Problem requesting IRQ with 2.4.2 kernel
References: <3A9BDC55.FCD90F9A@ipno.in2p3.fr> <20010227081059.B32137@cx258813-a.chnd1.az.home.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Matt Porter wrote:

> On Tue, Feb 27, 2001 at 05:56:53PM +0100, xav wrote:
> >
> > Hi !
> >
> > I'm using a clone of the bk tree to compile a 2.4.2 kernel.
> > I have also downloaded the code from Gabriel Paubert for the
> > pci2vme chip from TUNDRA.
>
> Which bk tree? linuxppc_2_4 or linuxppc_2_5?

linuxppc_2_4

> Interrupt routing problem.  IIRC, put a 5 for the interrupt line in
> the entry for Slot 13, Universe II LINT#0.  That should get you
> going.  Check the 2300 programmer's reference if that interrupt
>  doesn't work for you.  If the driver is using more LINT inputs than
> that then you'll have to fix the routing as appropriate.  It can all
> be rerouted via the Universe II but that's another game.

After I did it, I have the following :

00:0d.0 Bridge: Tundra Semiconductor Corp. CA91C042 [Universe] (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min)
        Interrupt: pin A routed to IRQ 21
        Region 0: Memory at effef000 (32-bit, non-prefetchable)
[size=4K]
        Region 1: I/O ports at fffe000 [size=4K]

No more module problem ! Thanks a lot...

--
33 (0) 1 69 15 79 59
De chacun selon ses forces, a chacun selon ses besoins


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
