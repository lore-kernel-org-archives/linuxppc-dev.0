Date: Fri, 24 Mar 2000 17:07:23 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: LongTrail PCI resource assignment
In-Reply-To: <Pine.GSO.4.10.10003241433140.7616-100000@dandelion.sonytel.be>
Message-ID: <Pine.LNX.4.10.10003241449270.21215-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Fine with me. I forgot to mention that I'm currently working on the 2.2.15
> > atyfb source, do your patches apply to that as well? (Frankly, I tried to
> > follow your argument about the PCI / OF resource handling but couldn't
> > make out where it would fit in with the problem I try to solve.)
>
> For 2.2.15, I suggest doing it in atyfb manually. But it will be quite
> difficult to find a suitable free hole in PCI memory space without the resource
> management subsystem.

I just want to reduce the vram and mmio apertures to the minimum sizes and
make them non overlapping.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
