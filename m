Message-ID: <39357BC5.A0B3E713@ccrl.mot.com>
Date: Wed, 31 May 2000 15:53:25 -0500
From: Steve Rossi <srossi@ccrl.mot.com>
MIME-Version: 1.0
To: Dan Malek <dan@netx4.com>
CC: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: allocating non-cacheable regions
References: <39104A07.D997B6C5@ccrl.mot.com> <3910838C.986942D6@embeddededge.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm back on this ... with another question. Following the examples in
commproc.c and enet.c - does setting the _PAGE_NO_CACHE flag
for a page table entry also invalidate any cached data for that page?
I am observing a write-though behavior when I write to addresses in
the _PAGE_NO_CACHE page but when I read from addresses marked
as _PAGE_NO_CACHE it appears to be retrieving data from the cache
not from memory. Is this expected behavior? How can I make it so that
reads as well as writes to a particular page bypass the cache?

Thanks,
Steve

Dan Malek wrote:

> Steve Rossi wrote:
> >
> > How do I allocate a region of memory that is flagged as being
> > non-cacheable?
>
> For an example, look at the commproc.c or enet.c driver in the
> arch/ppc/8xx_io directory.  When pages are allocated, the PTEs are
> tracked down and marked non-cache.
>

--
-------------------------------------------------------
Steven K. Rossi                     srossi@ccrl.mot.com
Staff Engineer
Multimedia Communications Research Laboratory
Motorola Labs
-------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
