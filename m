Date: Mon, 15 Jan 2001 20:24:49 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Iain Sandoe <iain@sandoe.co.uk>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: bk 2.4.1pre2 Lombard PCI allocation fails.
In-Reply-To: <Pine.LNX.4.05.10101151830580.31039-100000@callisto.of.borg>
Message-ID: <Pine.LNX.4.30.0101152023520.23098-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > > PCI: Cannot allocate resource region 1 of device 00:11.0
>          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> The conflict for the overlapping MMIO region.
>
> > >   got res[10000000:10000fff] for resource 2 of ATI Technologies Inc 3D Rage
> > > LT Pro
>
> Fixed by the kernel, and reassigned to 0x10000000.

OK, I misread that error message. Now you just need to supply a valid new
region :-) (How did the 2.3.99 code differ in that respect?)

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
