Message-ID: <393CF541.4E4D88B7@pop.agri.ch>
Date: Tue, 06 Jun 2000 14:57:37 +0200
From: Andreas Tobler <toa@pop.agri.ch>
MIME-Version: 1.0
To: mlan@cpu.lu
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2940UW & 2.4.0-test-ac7 PCI probs
References: <200006061136.NAA01541@piglet.grunz.lu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Michel Lanners wrote:
> >   for root[0:ffffffff] min[1000] size[100]
> >   got res[1000:10ff] for resource 0
>
> This must be the conflicting resource, but it gets an equally-wrong new
> address :-(( In fact, the PCI resource code still misses a patch to make
> the correct resources available to the resource allocation code (so that
> IO regions can be taken out of the IO region of the correct PCI bus..)
>
> I'm still working on that part ;-)

Thanks!

>
> So if the SCSI driver actually uses the IO region, it will most
> certainly not work....

How do I find that out?

Below it says I/O ports unassigned and it works. (2399p9)

00:0e.0 SCSI storage controller: Adaptec AIC-7881U
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 8 min, 8 max, 32 set, cache line size 08
        Interrupt: pin A routed to IRQ 24
        Region 0: I/O ports at <unassigned>
        Region 1: Memory at 80801000 (32-bit, non-prefetchable)

Andreas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
