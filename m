Date: Fri, 24 Mar 2000 17:30:01 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: michdaen@iiic.ethz.ch
cc: Geert Uytterhoeven <geert@linux-m68k.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: LongTrail PCI resource assignment
In-Reply-To: <20000324154247.10557.qmail@web120.yahoomail.com>
Message-ID: <Pine.LNX.4.10.10003241715130.21215-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Bug in X: the big endian frame buffer is at base + 0x800000.
>
> It doesn't know about the meaning behind the regions.

And X uses the base address and offset returned by fb_mmap anyway. The
whole probing of PCI resources is completely pointless for the framebuffer
driver. That's what the kernel framebuffer code is for IMHO (and I think
Geert will agree on that).

> > Besides, why does X need this? If it uses fbdev, all it should notice is
> > that the reported fix.smem_start lies within the 16 MB for this PCI device,
> > so it should not touch that PCI directly, only through the fbdev API
> > (ioctl+mmap).
>
> You should discuss that on the X-devel list, in particular with Egbert Eich
> (and Jeff Garzik, and ... :).

I'd like to reach a point where I understand what's happening in the
XFree PCI code before getting into that sort of discussion. And the X
source is way too convoluted for me to achieve that right now.

I'll stick to pre-4.0 XFree rather.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
