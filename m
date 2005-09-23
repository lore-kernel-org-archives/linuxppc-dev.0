Return-Path: <hch@lst.de>
Date: Fri, 23 Sep 2005 11:08:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jon Loeliger <jdl@freescale.com>
Message-ID: <20050923090809.GA31688@lst.de>
References: <E1EIVg5-0001HI-E8@jdl.com> <20050922183126.GA18853@lst.de>
	<E1EIVwC-0001IQ-5s@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1EIVwC-0001IQ-5s@jdl.com>
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: Re: PATCH powerpc Merge asm-ppc*/seccomp.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 22, 2005 at 01:36:52PM -0500, Jon Loeliger wrote:
> So, like, the other day Christoph Hellwig mumbled:
> > > +#include <linux/thread_info.h>
> > > +
> > > +#if defined(__powerpc64__) && !defined(TIF_32BIT)
> > > +#error "unexpected TIF_32BIT on ppc64"
> > > +#endif
> > 
> > just kill this check, it's rather pointless
> 
> OK.
> 
> But keep the #include?  It's actually the part
> that is defining TIF_32BIT for ppc64 (indirectly
> through linux/thread_info.h and asm/thread_info.h).
> Won't those bits be needed still?

I'm not sure.  This header definitly doesn't need it, but I suspect
seccompt.c expects to get it via this header.
