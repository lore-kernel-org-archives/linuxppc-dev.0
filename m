MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: ioremap on powerpc question
Date: Wed, 17 Jul 2002 17:39:24 -0500
Message-ID: <45B36A38D959B44CB032DA427A6E10640167D000@cceexc18.americas.cpqcorp.net>
From: "Cameron, Steve" <Steve.Cameron@hp.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I wrote:
> Hmm, I continue to have difficulties...
>
> Matt Porter wrote:
> > On Mon, Jul 15, 2002 at 01:58:21PM -0500, Cameron, Steve wrote:
> > > It blows up with a machine check.
[...]
> > Try this patch:
[...]
> when I attempt to DMA into the physical address with my PCI device,
> it is as if the DMA never occurs.  Prior to the DMA, I fill the
> buffer with 0x55's, and after the DMA, the 0x55's are still there.
[...].
>
> BTW, my device seems happy with the physical addresses I pass it,
[...]
And now I see, I have (at least) two errors, one hiding the other.  In fact
my PCI device was _not_ happy with those addresses at all, (because they
were wrong, I botched the swapping) and also my code to check for this device's
unhappiness happened to be broken...

So, now I think ioremap is likely now working with this patch.

Thanks, and sorry for all the noise.

(still not sure about my problems with alloc_bootmem_pages, but
not too worried about it now.)

-- steve


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
