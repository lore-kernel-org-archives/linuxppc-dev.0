Message-Id: <200004262254.PAA23995@pop3.ucdavis.edu>
Date: Wed, 26 Apr 2000 15:54:18 -0700
Subject: Re: XFree 4.0 dual monitor on AGP G4
From: "W. Taylor Holliday" <wtholliday@ucdavis.edu>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
CC: daenzerm@student.ethz.ch, linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Care to post a lspci -vv log?
>
>  Michael

noprob, here it is

00:0d.0 PCI bridge: Digital Equipment Corporation DECchip 21154 (rev 05)
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
 Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 32 set, cache line size 08
 Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
 I/O behind bridge: 00001000-00001fff
 Memory behind bridge: 80000000-87ffffff
 Prefetchable memory behind bridge: 0000000080000000-000000007ff00000
 BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-

00:10.0 VGA compatible controller: ATI Technologies Inc: Unknown device 5246
 Subsystem: Unknown device b530:0408
 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
 Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 8 min, 255 set, cache line size 08
 Interrupt: pin A routed to IRQ 48
 Region 0: Memory at 94000000 (32-bit, prefetchable)
 Region 1: I/O ports at 0400 [disabled]
 Region 2: Memory at 90000000 (32-bit, non-prefetchable)
 Capabilities: <available only to root>

01:02.0 SCSI storage controller: Adaptec AIC-7850 (rev 03)
 Subsystem: Unknown device 9004:7850
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 4 min, 4 max, 16 set, cache line size 08
 Interrupt: pin A routed to IRQ 52
 Region 0: I/O ports at <unassigned>
 Region 1: Memory at 80084000 (32-bit, non-prefetchable)
 Capabilities: <available only to root>

01:03.0 VGA compatible controller: ATI Technologies Inc: Unknown device 5245
 Subsystem: Unknown device b530:0408
 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
 Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 8 min, 16 set, cache line size 08
 Interrupt: pin A routed to IRQ 53
 Region 0: Memory at 84000000 (32-bit, prefetchable)
 Region 1: I/O ports at 1000 [disabled]
 Region 2: Memory at 8008c000 (32-bit, non-prefetchable)
 Capabilities: <available only to root>

01:07.0 Class ff00: Apple Computer Inc.: Unknown device 0022 (rev 02)
 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 16 set, cache line size 08
 Region 0: Memory at 80000000 (32-bit, non-prefetchable)

01:08.0 USB Controller: Apple Computer Inc.: Unknown device 0019 (prog-if
10)
 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 3 min, 86 max, 16 set
 Interrupt: pin A routed to IRQ 27
 Region 0: Memory at 80083000 (32-bit, non-prefetchable)

01:09.0 USB Controller: Apple Computer Inc.: Unknown device 0019 (prog-if
10)
 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 3 min, 86 max, 16 set
 Interrupt: pin A routed to IRQ 28
 Region 0: Memory at 80082000 (32-bit, non-prefetchable)

01:0a.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8019
(prog-if 10)
 Control: I/O- Mem- BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Interrupt: pin A routed to IRQ 63
 Region 0: Memory at 80081000 (32-bit, non-prefetchable) [disabled]
 Region 1: Memory at 80088000 (32-bit, non-prefetchable) [disabled]
 Capabilities: <available only to root>

01:0b.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43
(rev 41)
 Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 20 min, 40 max, 96 set, cache line size 08
 Interrupt: pin A routed to IRQ 58
 Region 0: I/O ports at 1000
 Region 1: Memory at 80080000 (32-bit, non-prefetchable) [disabled]
 Capabilities: <available only to root>


Thanx again for your help
(I think I previously posted my /proc/pci if u need it)

- Taylor

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
