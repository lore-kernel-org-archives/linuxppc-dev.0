Return-Path: <kumar.gala@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 562A867A73
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Mar 2005 16:25:51 +1100 (EST)
In-Reply-To: <423600F9.5050705@timesys.com>
References: <423600F9.5050705@timesys.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <8885f1c9929c312a1f780ef10b05b1aa@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Mon, 14 Mar 2005 23:25:17 -0600
To: "Greg Weeks" <greg.weeks@timesys.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: mpc8560ads PCI bus
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Greg good to hear, I was about to comment on the fact that PCI based=20
support had been working on the 8540/8560 ADS systems.

- kumar

On Mar 14, 2005, at 3:24 PM, Greg Weeks wrote:

> Switch bank SW1 switch #4 was on which stops config accesses from=20
> making
> it on the bus. It works fine now.
>
> Greg Weeks
>
> Clemens Koller wrote:
>
> > Hello, Greg,
>  >
>  > I am working on an mpc8540_ads-like board and recently, I ran into=20=

> data
>  > corruption problems with a Silicon Motion SM501 (Rev AA) PCI=20
> graphics
> > card. =46rom my current point of view it seems that Kernel 2.6.11 =
PCI
> > works well. I am about to check the hardware and signal integrity.
> >
>  > BTW: I am working with a Promise Ultra-TX133 IDE controller=20
> (PDC20269)
>  > which is fine with 66MHz PCICLK.
>  >
>  > Greets,
>  >
>  > Clemens
>  >
>  >
>  >> Has anyone else tried to get the PCI bus working on the mpc8560ads
> >> board at 2.6.11? The card enumerates, but the I/O resource regions
> >> aren't getting set up.
> >>
>  >> -bash-2.05b# lspci -vv
>  >> 00:03.0 Unknown mass storage controller: Silicon Image, Inc.
> >> (formerly CMD Technology Inc) PCI0680 Ultra ATA-133 Host Controller
>  >> (rev 02)
>  >>=A0=A0=A0=A0=A0=A0=A0 Subsystem: Silicon Image, Inc. (formerly CMD =
Technology Inc)
> >> PCI0680 Ultra ATA-133 Host Controller
> >>=A0=A0=A0=A0=A0=A0=A0 Control: I/O- Mem- BusMaster- SpecCycle- =
MemWINV- VGASnoop-
> >> ParErr- Stepping- SERR- FastB2B-
>  >>=A0=A0=A0=A0=A0=A0=A0 Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- =
DEVSEL=3Dmedium
>  >> >TAbort- <TAbort- <MAbort- >SERR- <PERR+
>  >>=A0=A0=A0=A0=A0=A0=A0 Interrupt: pin A routed to IRQ 100
>  >>=A0=A0=A0=A0=A0=A0=A0 Region 0: I/O ports at <unassigned> =
[disabled]
>  >>=A0=A0=A0=A0=A0=A0=A0 Region 1: I/O ports at <unassigned> =
[disabled]
>  >>=A0=A0=A0=A0=A0=A0=A0 Region 2: I/O ports at <unassigned> =
[disabled]
>  >>=A0=A0=A0=A0=A0=A0=A0 Region 3: I/O ports at <unassigned> =
[disabled]
>  >>=A0=A0=A0=A0=A0=A0=A0 Region 4: I/O ports at <unassigned> =
[disabled]
>  >>=A0=A0=A0=A0=A0=A0=A0 Capabilities: [60] Power Management version 2
>  >>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Flags: PMEClk- DSI+ =
D1+ D2+ AuxCurrent=3D0mA
>  >> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>  >>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Status: D0 =
PME-Enable- DSel=3D0 DScale=3D2 PME-
>  >>
>  >> Greg Weeks
>  >> _______________________________________________
> >> Linuxppc-embedded mailing list
>  >> Linuxppc-embedded@ozlabs.org
> >> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>  >>
>  >
>
> _______________________________________________
> Linuxppc-embedded mailing list
>  Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
