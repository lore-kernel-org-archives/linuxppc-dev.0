Date: Wed, 22 Dec 1999 13:26:57 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Kostas Gewrgiou <gewrgiou@imbc.gr>,
        "Jens Ch. Restemeier" <jrestemeier@currantbun.com>,
        "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Update - Re: Open Sourced Glide on Linux PPC
In-Reply-To: <Pine.LNX.4.05.9912222035500.574-100000@callisto.of.borg>
Message-ID: <Pine.LNX.3.96.991222132409.836B-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 22 Dec 1999, Geert Uytterhoeven wrote:
> >   They do all memory access through the GETxx SETxx defines you can 
> > do the byteswapping there, the linux specific code doesn't use this 
> > though so you'll have to change this too.

> Use read*()/write*() for all accesses to PCI memory space, as per
> linux/Documentation/IO-mapping.txt.

I don't know if this applies to the problem, but I thought I would
reference the VGA read/write routines in drivers/video/vga.h.  If Glide
has to talk to VGA registers, the functions in there should be best
for most uses.  They take endianness into account too.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
