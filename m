Mime-Version: 1.0
Message-Id: <p04330103b6caab5dee89@[38.205.4.5]>
Date: Tue, 6 Mar 2001 09:59:17 -0500
To: linuxppc-dev@lists.linuxppc.org (linux)
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: 2.4.2 USB and "mon>" (was Re: All 6 cards!!!)
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Refer to
<http://lists.linuxppc.org/listarcs/linuxppc-user/200103/msg00229.html>

Running 2.4.2 (kfukui) on 9500-class machine with an OrangeMicro USB
firewire card [ADB keyboard + USB mouse], have noted 2 things:


1. I get a "mon>" prompt on about half of the boots. And on half of
those, typing "x" exits me from mon and continues the boot. The rest
just hang. What is mon anyway? I've already seen reference to this on
the user list, not sure what the solution is...

2. No USB mouse response in X. lspci -vv, in part, gives:

01:0d.0 USB Controller: OPTi Inc. 82C861 (rev 10) (prog-if 10 [OHCI])
         Subsystem: OPTi Inc.: Unknown device c861
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort+ <MAbort- >SERR- <PERR-
         Latency: 32 set, cache line size 08
         Interrupt: pin A routed to IRQ 1
         Region 0: Memory at 80800000 (32-bit, non-prefetchable) [size=4K]


I'm concerned about the "IRQ 1". Is "1" correct?

I can live with the mon, but not without my mouse. Any suggestions here?


Stefan Jeglinski

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
