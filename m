Return-Path: <greg.weeks@timesys.com>
Received: from exchange.timesys.com (mail.timesys.com [65.117.135.102])
	by ozlabs.org (Postfix) with ESMTP id 7A0FB67A6B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Mar 2005 02:09:02 +1100 (EST)
Message-ID: <4235A636.4020309@timesys.com>
Date: Mon, 14 Mar 2005 09:56:54 -0500
From: Greg Weeks <greg.weeks@timesys.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: mpc8560ads PCI bus
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Has anyone else tried to get the PCI bus working on the mpc8560ads board 
at 2.6.11? The card enumerates, but the I/O resource regions aren't 
getting set up.

-bash-2.05b# lspci -vv
00:03.0 Unknown mass storage controller: Silicon Image, Inc. (formerly 
CMD Technology Inc) PCI0680 Ultra ATA-133 Host Controller (rev 02)
        Subsystem: Silicon Image, Inc. (formerly CMD Technology Inc) 
PCI0680 Ultra ATA-133 Host Controller
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR+
        Interrupt: pin A routed to IRQ 100
        Region 0: I/O ports at <unassigned> [disabled]
        Region 1: I/O ports at <unassigned> [disabled]
        Region 2: I/O ports at <unassigned> [disabled]
        Region 3: I/O ports at <unassigned> [disabled]
        Region 4: I/O ports at <unassigned> [disabled]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-
 
Greg Weeks
