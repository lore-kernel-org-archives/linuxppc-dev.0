Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.176]) by ozlabs.org (Postfix) with ESMTP id 4CEAB67A65
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Mar 2005 02:40:12 +1100 (EST)
Message-ID: <4235B13C.9010604@anagramm.de>
Date: Mon, 14 Mar 2005 16:43:56 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Greg Weeks <greg.weeks@timesys.com>, linuxppc-embedded@ozlabs.org
References: <4235A636.4020309@timesys.com>
In-Reply-To: <4235A636.4020309@timesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Hello, Greg,

I am working on an mpc8540_ads-like board and recently, I ran into data
corruption problems with a Silicon Motion SM501 (Rev AA) PCI graphics 
card. From my current point of view it seems that Kernel 2.6.11 PCI 
works well. I am about to check the hardware and signal integrity.

BTW: I am working with a Promise Ultra-TX133 IDE controller (PDC20269)
which is fine with 66MHz PCICLK.

Greets,

Clemens


> Has anyone else tried to get the PCI bus working on the mpc8560ads board 
> at 2.6.11? The card enumerates, but the I/O resource regions aren't 
> getting set up.
> 
> -bash-2.05b# lspci -vv
> 00:03.0 Unknown mass storage controller: Silicon Image, Inc. (formerly 
> CMD Technology Inc) PCI0680 Ultra ATA-133 Host Controller (rev 02)
>        Subsystem: Silicon Image, Inc. (formerly CMD Technology Inc) 
> PCI0680 Ultra ATA-133 Host Controller
>        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
>        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR+
>        Interrupt: pin A routed to IRQ 100
>        Region 0: I/O ports at <unassigned> [disabled]
>        Region 1: I/O ports at <unassigned> [disabled]
>        Region 2: I/O ports at <unassigned> [disabled]
>        Region 3: I/O ports at <unassigned> [disabled]
>        Region 4: I/O ports at <unassigned> [disabled]
>        Capabilities: [60] Power Management version 2
>                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                Status: D0 PME-Enable- DSel=0 DScale=2 PME-
> 
> Greg Weeks
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 

-- 
Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19
