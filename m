Date: Tue, 14 Mar 2000 11:05:52 +0100 (MET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linux-fbdev@vuser.vu.union.edu, linuxppc-dev@lists.linuxppc.org
Subject: Re: [linux-fbdev] [PATCH 2.3.x] fbdev reversion
In-Reply-To: <20000314110314.016060@mailhost.mipsys.com>
Message-ID: <Pine.GSO.4.10.10003141104380.15255-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 14 Mar 2000, Benjamin Herrenschmidt wrote:
> On Tue, Mar 14, 2000, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> wrote:
> Well, while we are at it, we could also work on fixing the PCI problems:
> Instead of relying on XFree knowing the host bridge and deducing the
> iobase, I beleive we should export from the kernel either one iobase per
> PCI device (there can be different busses with different iobases, that's
> the case on the new macs and they have the same bus number), or we can
> have /proc/bus/pci export "fixed'up" IO addresses (already including the
> iobase).
>
> I can code those fixes, but I'm not sure what solution has most chances
> of beeing accepted (especially changing /poc/bus/pci semantics). The
> problem is that exporting an IO address alone (without the iobase) has
> really no meaning on arch that don't have a x86-like separate IO space at
> the CPU level.

Have you talked to Martin Mares about this?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248638 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
