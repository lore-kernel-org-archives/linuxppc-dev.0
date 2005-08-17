Return-Path: <SRS0+012e81371fdbb5a82166+724+infradead.org+hch@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D053A67FAD
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Aug 2005 19:09:29 +1000 (EST)
Date: Wed, 17 Aug 2005 10:09:20 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Message-ID: <20050817090920.GA12716@infradead.org>
References: <20050816.203312.77701192.davem@davemloft.net>
	<032E6AED-9456-4271-9B06-C5DCE5970193@freescale.com>
	<20050817083048.GA11892@infradead.org>
	<E1E5Jii-0004Yc-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1E5Jii-0004Yc-00@dorka.pomaz.szeredi.hu>
Cc: akpm@osdl.org, zach@vmware.com, linux-kernel@vger.kernel.org,
	hch@infradead.org, linuxppc-dev@ozlabs.org, galak@freescale.com,
	davem@davemloft.net
Subject: Re: [PATCH] ppc32: removed usage of <asm/segment.h>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 17, 2005 at 10:56:24AM +0200, Miklos Szeredi wrote:
> > On Wed, Aug 17, 2005 at 12:43:37AM -0500, Kumar Gala wrote:
> > > >I concur, in fact we should really kill that thing off entirely.
> > > 
> > > I'm all for killing it off entirely but got some feedback that on  
> > > i386 segment.h can be included by userspace programs.
> > 
> > No kernel headers can be included by userland anymore.
> 
> I know nothing about <asm/segment.h> but this generic statement is
> simply not true.
> 
> There are perfectly valid uses of kernel headers from userspace.  For
> example if a program uses the netlink interface, it should include
> <linux/netlink.h>.  It's the interface definition after all.
> 
> Glibc headers also include <linux/*> and <asm/*> in quite few places.

But these files in /usr/include/ aren't provided by the kernel anymore.
