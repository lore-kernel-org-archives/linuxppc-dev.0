MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14805.365.429694.38306@esb.bbn.com>
Date: Fri, 29 Sep 2000 16:54:05 -0400
From: R Shapiro <rshapiro@bbn.com>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
        Michel Ddnzer <daenzerm@student.ethz.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.1 + ati driver with rage II/rage pro
In-Reply-To: <Pine.LNX.4.10.10009292131510.7428-100000@opal.biophys.uni-duesseldorf.de>
References: <14804.46688.113509.984458@esb.bbn.com>
	<Pine.LNX.4.10.10009292131510.7428-100000@opal.biophys.uni-duesseldorf.de>
Reply-To: rshapiro@bbn.com
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz writes:
 > > I tried miBoot.  Is that equivalent from the X perspective?
 >
 > Show me your lspci -vv log :-)

The result in miBoot is the same as in BootX:

00:00.0 Host bridge: Motorola Computer Group MPC106 [Grackle] (rev 40)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort+ <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0 set, cache line size 08

00:0d.0 VGA compatible controller: ATI Technologies Inc 215GI [Mach64 GI] (rev 5c)
	Subsystem: Unknown device 1002:0000
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 8 min, 32 set, cache line size 08
	Interrupt: pin A routed to IRQ 23
	Region 0: Memory at 84000000 (32-bit, prefetchable)
	Region 1: I/O ports at 0400 [disabled]
	Region 2: Memory at 81801000 (32-bit, non-prefetchable)

00:0f.0 VGA compatible controller: ATI Technologies Inc 215GI [Mach64 GI] (rev 5c)
	Subsystem: Unknown device 1002:0000
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 8 min, 32 set, cache line size 08
	Interrupt: pin A routed to IRQ 25
	Region 0: Memory at 83000000 (32-bit, prefetchable)
	Region 1: I/O ports at 0400 [disabled]
	Region 2: Memory at 81800000 (32-bit, non-prefetchable)

00:10.0 Class ff00: Apple Computer Inc. Heathrow Mac I/O (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 set, cache line size 08
	Region 0: Memory at f3000000 (32-bit, non-prefetchable)

00:12.0 VGA compatible controller: ATI Technologies Inc 215GT [Mach64 GT] (rev 9a)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 8 min, 32 set, cache line size 08
	Interrupt: pin A routed to IRQ 22
	Region 0: Memory at 82000000 (32-bit, non-prefetchable)
	Region 1: I/O ports at 0400 [disabled]




 > Re: OF device tree, there's a tool named lsprop you need to run on
 > /proc/device_tree (see Paul's or BenH's pages for the source or ask me
 > for a copy).

Monday...

--
rshapiro@bbn.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
