Date: Wed, 8 Dec 1999 17:25:54 -0600
From: Grant Erickson <grant@lcse.umn.edu>
To: Dan Malek <dmalek@jlc.net>
cc: linuxppc-embedded@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: PPC Cache Flush and Invalidate Routines
In-Reply-To: <384EF3D1.DFC1D281@jlc.net>
Message-ID: <Pine.SGI.4.10.9912081721580.155726-100000@brule.borg.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 8 Dec 1999, Dan Malek wrote:
> Grant Erickson wrote:
> > In trying to accomodate the 4xx-based code into the Linux kernel, I've
> > encountered an issue which relates to the cache flushing and invalidation
> > routines in misc.S.
> >
> > Thoughts, opinions?
> 
> We could simply create a configuration #define for the cache line size
> that is assigned in the 'make config' scripts when the processor type
> is chosen.

In general, I like that idea; however, the 4xx messes things up.

I'd like to have a kernel that will boot on any 4xx-based board (maybe or
maybe not realistic), so because the 403 uses 16 byte lines and the 405
uses 32 byte lines, I need a dynamic solution such as the one Gary
suggested.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
