Message-ID: <38DFCCBA.5588C870@pop.agri.ch>
Date: Mon, 27 Mar 2000 23:03:56 +0200
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
CC: Michel Lanners <mlan@cpu.lu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: pci-resources feedback
References: <Pine.LNX.4.10.10003272157250.2447-100000@opal.biophys.uni-duesseldorf.de>
Content-Type: multipart/mixed;
 boundary="------------36CF1B1A44C00F6FAECF8B0C"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------36CF1B1A44C00F6FAECF8B0C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit



Michael Schmitz wrote:
>
> >
> > Here the resource code notices the conflict on the ATI.
> >
> > > PCI: Resource 81803000-81803fff (f=200, d=0, p=0)
> > > PCI: Resource 81802000-81802fff (f=200, d=0, p=0)
> > >   for root[0:ffffffff] min[80000000] size[1000]
> > >   got res[80000000:80000fff] for resource 2
> >
> > This is the message as the conflicting (second) region of the ATI gets
> > remapped. It did work... as can be seen ba the lspci outtput.
>
> And it even used the right function (the one in drivers/pci/ to do it. Now
> what kernel version was that with?
>
> Seems the wallstreet was another one of the 'broken mapping for atyfb'
> boxes. XFree86 4.0 should work fine now.

As written 2399pre3 on a wallstreet I (spring 98)

If needed more input/output?

Thx
Andreas

btw, attached the lspci -vv for the whole tree
--------------36CF1B1A44C00F6FAECF8B0C
Content-Type: image/x-xbitmap; x-mac-type="3F3F3F3F"; x-mac-creator="554E4958";
 name="pci-dump2399.log"
Content-Description: Document
Content-Disposition: inline;
 filename="pci-dump2399.log"
Content-Transfer-Encoding: 7bit

00:00.0 Host bridge: Motorola Computer Group MPC106 [Grackle] (rev 40)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort+ <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 0 set, cache line size 08

00:0d.0 Class ff00: Apple Computer Inc. Heathrow Mac I/O (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 32 set, cache line size 08
	Region 0: Memory at f4000000 (32-bit, non-prefetchable)

00:10.0 Class ff00: Apple Computer Inc. Heathrow Mac I/O (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 32 set, cache line size 08
	Region 0: Memory at f3000000 (32-bit, non-prefetchable)

00:11.0 VGA compatible controller: ATI Technologies Inc 215LG [Mach64 LG] (rev 80)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 8 min, 32 set, cache line size 08
	Interrupt: pin A routed to IRQ 24
	Region 0: Memory at 82000000 (32-bit, non-prefetchable)
	Region 1: I/O ports at fe000400
	Region 2: Memory at 80000000 (32-bit, non-prefetchable)

00:13.0 CardBus bridge: Texas Instruments PCI1131 (rev 01)
	Subsystem: Unknown device 104c:ac15
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 set, cache line size 08
	Interrupt: pin A routed to IRQ 22
	Region 0: Memory at 81803000 (32-bit, non-prefetchable)
	Bus: primary=00, secondary=01, subordinate=04, sec-latency=64
Memory window 0: 90000000-90005000
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
	16-bit legacy interface ports at 0007

00:13.1 CardBus bridge: Texas Instruments PCI1131 (rev 01)
	Subsystem: Unknown device 104c:ac15
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 set, cache line size 08
	Interrupt: pin B routed to IRQ 23
	Region 0: Memory at 81802000 (32-bit, non-prefetchable)
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=64
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt- PostWrite-
	16-bit legacy interface ports at 0007


--------------36CF1B1A44C00F6FAECF8B0C--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
