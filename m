From: Jeremy Rosen <Jeremy.Rosen@au.thalesgroup.com>
To: linuxppc-embedded@lists.linuxppc.org
Message-Id: <scac60f5.069@au.thalesgroup.com>
Date: Thu, 04 Apr 2002 14:19:11 +1000
Subject: Re: Workaround for USB DMA bugs
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>I guess if we can ensure a DMA-only pool, simple alignment will work.
>You just can't kmalloc() because you don't know what may follow
something
>that isn't modulo cache line size.  You also have to be careful of
code
>that allocates a large object, then uses part of it for DMA and other
>parts for processor core data.  I'm not sure we want to require
kmalloc()
>to always cache align due to the potential for wasted memory space.

can't we use the __GFP_DMA flag to specify that the area must have
algnment enforced ?
or did I misunderstand the use of this flag ?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
