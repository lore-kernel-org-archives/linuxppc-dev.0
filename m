Return-Path: <miklos@szeredi.hu>
Received: from dorka.pomaz.szeredi.hu (adsl-266.mirage.euroweb.hu
	[193.226.239.10]) by ozlabs.org (Postfix) with ESMTP id 0BB9567FCD
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Aug 2005 19:23:03 +1000 (EST)
To: hch@infradead.org
In-reply-to: <20050817083048.GA11892@infradead.org> (message from Christoph
	Hellwig on Wed, 17 Aug 2005 09:30:48 +0100)
References: <20050816.203312.77701192.davem@davemloft.net>
	<032E6AED-9456-4271-9B06-C5DCE5970193@freescale.com>
	<20050817083048.GA11892@infradead.org>
Message-Id: <E1E5Jii-0004Yc-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 17 Aug 2005 10:56:24 +0200
Cc: akpm@osdl.org, zach@vmware.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, galak@freescale.com, davem@davemloft.net
Subject: Re: [PATCH] ppc32: removed usage of <asm/segment.h>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> On Wed, Aug 17, 2005 at 12:43:37AM -0500, Kumar Gala wrote:
> > >I concur, in fact we should really kill that thing off entirely.
> > 
> > I'm all for killing it off entirely but got some feedback that on  
> > i386 segment.h can be included by userspace programs.
> 
> No kernel headers can be included by userland anymore.

I know nothing about <asm/segment.h> but this generic statement is
simply not true.

There are perfectly valid uses of kernel headers from userspace.  For
example if a program uses the netlink interface, it should include
<linux/netlink.h>.  It's the interface definition after all.

Glibc headers also include <linux/*> and <asm/*> in quite few places.

Miklos
