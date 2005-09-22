Return-Path: <jdl@jdl.com>
From: Jon Loeliger <jdl@freescale.com>
To: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
In-Reply-To: Your message of "Thu, 22 Sep 2005 20:31:26 +0200."
	<20050922183126.GA18853@lst.de>
References: <E1EIVg5-0001HI-E8@jdl.com>  <20050922183126.GA18853@lst.de> 
Date: Thu, 22 Sep 2005 13:36:52 -0500
Message-Id: <E1EIVwC-0001IQ-5s@jdl.com>
Sender: Jon Loeliger <jdl@jdl.com>
Subject: Re: PATCH powerpc Merge asm-ppc*/seccomp.h 
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Christoph Hellwig mumbled:
> > +#include <linux/thread_info.h>
> > +
> > +#if defined(__powerpc64__) && !defined(TIF_32BIT)
> > +#error "unexpected TIF_32BIT on ppc64"
> > +#endif
> 
> just kill this check, it's rather pointless

OK.

But keep the #include?  It's actually the part
that is defining TIF_32BIT for ppc64 (indirectly
through linux/thread_info.h and asm/thread_info.h).
Won't those bits be needed still?

jdl
