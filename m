Date: Wed, 31 May 2000 09:45:20 -0400
From: Josh Huber <huberj@wpi.edu>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Lite-On ethernet controller
Message-ID: <20000531094520.B652@mclinux.com>
References: <20000531090215.A652@mclinux.com> <3935145C.DE1F478D@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gBBFr7Ir9EOA20Yy"
In-Reply-To: <3935145C.DE1F478D@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Wed, May 31, 2000 at 09:32:12AM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 31, 2000 at 09:32:12AM -0400, Jeff Garzik wrote:
> I don't understand what you mean here.
Sorry I wasn't clear.

The Tulip driver in the devel kernels is not working for me. Supposedly,
this card works with the driver in later 2.2 kernels.  I can't get 2.2.x to
boot on this machine I have, which is why I'm using 2.4 pre versions.

What I meant by the newer tulip driver was the version available from Don
Becker's tulip development page.

> > Does anyone know of forward-ported tulip drivers?
>
> A tulip driver exists in the 2.4pre kernel.  Are you having problems
> with that driver?
Yes.

> > The particular error I'm seeing only happens with moderate load -- pings and
> > other light traffic work 100%.
> >
> > Error information:
> > NETDEV WATCHDOG: eth1: transmit timed out
> > Transmit timed out, status e4660000, CSR12 000050ca, resetting...
> >
> > Device information:
> > tulip driver output:
> > eth1: Lite-On PNIC-II rev 37 at 0x1c00, 00:00:94:C5:EF:FF, IRQ 30.
>
> IRQ 30?  Is that ok for PPC?
Yes, here's the output from /proc/interrupts:
              CPU0
     1:       1820   i8259         keyboard
     2:          0   i8259         82c59 secondary cascade
     8:          2   i8259         rtc
    16:          0   OpenPIC       82c59 cascade
    27:          0   OpenPIC       NMI
    29:       4872   OpenPIC       eth0
    30:       4624   OpenPIC       eth1
    31:       6377   OpenPIC       aic7xxx

eth0 is an actual DEC tulip card, which works great.

> > lspci -vv output attached because it's too wide.
> No attachment...

Heh, sorry.  I'll attach it this time.

Josh

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lspci.out"

00:05.0 Ethernet controller: Lite-On Communications Inc: Unknown device c115 (rev 25)
        Subsystem: Asante Technologies, Inc.: Unknown device f001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 8 min, 56 max, 32 set, cache line size 08
        Interrupt: pin A routed to IRQ 30
        Region 0: I/O ports at 1c00 [size=256]
        Region 1: Memory at c3002000 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at c1240000 [disabled] [size=256K]
        Capabilities: [44] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
--gBBFr7Ir9EOA20Yy--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
