Date: Fri, 29 Sep 2000 23:04:38 +0200 (CEST)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: R Shapiro <rshapiro@bbn.com>
cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        Michel Dänzer <daenzerm@student.ethz.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.1 + ati driver with rage II/rage pro
In-Reply-To: <14805.365.429694.38306@esb.bbn.com>
Message-ID: <Pine.LNX.4.10.10009292301200.20389-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>  > Show me your lspci -vv log :-)
>
> The result in miBoot is the same as in BootX:
>
> 00:0d.0 VGA compatible controller: ATI Technologies Inc 215GI [Mach64 GI] (rev 5c)
> 	Interrupt: pin A routed to IRQ 23
> 	Region 0: Memory at 84000000 (32-bit, prefetchable)
> 	Region 1: I/O ports at 0400 [disabled]
> 	Region 2: Memory at 81801000 (32-bit, non-prefetchable)
>
> 00:0f.0 VGA compatible controller: ATI Technologies Inc 215GI [Mach64 GI] (rev 5c)
> 	Interrupt: pin A routed to IRQ 25
> 	Region 0: Memory at 83000000 (32-bit, prefetchable)
> 	Region 1: I/O ports at 0400 [disabled]
> 	Region 2: Memory at 81800000 (32-bit, non-prefetchable)
>
> 00:12.0 VGA compatible controller: ATI Technologies Inc 215GT [Mach64 GT] (rev 9a)
> 	Interrupt: pin A routed to IRQ 22
> 	Region 0: Memory at 82000000 (32-bit, non-prefetchable)
> 	Region 1: I/O ports at 0400 [disabled]

That does indeed look legit to me, unless XFree decides to disable two out
of three because the (disabled) IO regions are identical.

Assuming the MMIO size is 0x1000 (which is the case for me).

Did the machine survice XFree86 -probeonly? If so, what's the mappings
after that?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
