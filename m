Subject: RE: PowerSpan PCI / sym2 SCSI
From: Hollis Blanchard <hollis@austin.ibm.com>
To: Ppc Developers <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <NCBBIINEHIPFGJPLBEIFEEBPDLAA.acurtis@onz.com>
References: <NCBBIINEHIPFGJPLBEIFEEBPDLAA.acurtis@onz.com>
Content-Type: text/plain
Date: 23 Aug 2002 11:19:55 -0500
Message-Id: <1030119595.6599.112.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2002-08-23 at 10:08, Allen Curtis wrote:
> > I didn't notice you were still having problems with version 1 of the
> > driver; I thought you had resolved that. IME that almost always means
> > your PCI config is not correct.
>
> I have used a peek/poke utility to access the SYM53C8xx via PCI memory and
> I/O. Both seem to be working fine. Obviously since the sym_2 driver works in
> at least one configuration, the translation from the PCI bus back to CPU
> memory is also correct.

Well, I would start by finding the error ("CACHE TEST FAILED: DMA error
(dstat=0x81)."), see under what conditions it occurs, and work backwards
from there.

It may really be that "normal IO" uses inb/outb. Do other drivers that
use ioremap/readb/writeb work on your system?

> Still feels like an endian issue to me.

I'm not sure it is an endian problem because as I mentioned I've used
the sym2 driver on PPC without problems.

-Hollis


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
