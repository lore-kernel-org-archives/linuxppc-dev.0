Message-ID: <20000324154247.10557.qmail@web120.yahoomail.com>
Date: Fri, 24 Mar 2000 07:42:47 -0800 (PST)
From: Michel "D?nzer" <mdaenzer@yahoo.com>
Reply-To: michdaen@iiic.ethz.ch
Subject: Re: LongTrail PCI resource assignment
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--- Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Bug in X: the big endian frame buffer is at base + 0x800000.

It doesn't know about the meaning behind the regions.


> Besides, why does X need this? If it uses fbdev, all it should notice is
> that the reported fix.smem_start lies within the 16 MB for this PCI device,
> so it should not touch that PCI directly, only through the fbdev API
> (ioctl+mmap).

You should discuss that on the X-devel list, in particular with Egbert Eich
(and Jeff Garzik, and ... :).


Michel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
