Return-Path: <miklos@szeredi.hu>
Received: from dorka.pomaz.szeredi.hu (adsl-266.mirage.euroweb.hu
	[193.226.239.10]) by ozlabs.org (Postfix) with ESMTP id 5C61A67FC9
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Aug 2005 20:08:49 +1000 (EST)
To: hch@infradead.org
In-reply-to: <20050817092041.GA12910@infradead.org> (message from Christoph
	Hellwig on Wed, 17 Aug 2005 10:20:41 +0100)
References: <20050816.203312.77701192.davem@davemloft.net>
	<032E6AED-9456-4271-9B06-C5DCE5970193@freescale.com>
	<20050817083048.GA11892@infradead.org>
	<E1E5Jii-0004Yc-00@dorka.pomaz.szeredi.hu>
	<20050817090920.GA12716@infradead.org>
	<E1E5K1L-0004bH-00@dorka.pomaz.szeredi.hu>
	<20050817092041.GA12910@infradead.org>
Message-Id: <E1E5KpP-0004dy-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 17 Aug 2005 12:07:23 +0200
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

> > They are provided by _one_ kernel, not necessarily the running kernel.
> 
> No, they're provided by packages like glibc-kernheaders or similar
> that are maintained separately.

Yes.  And "maintenance" I presume means "copy" the kernel headers and
do some cleanup to be compliant to the relevant standards (which the
kernel maintainers couldn't be bothered to do).

> They're split from the kernel headers and we don't need to keep
> obsolete junk around.

I agree about obsolete junk.

However statements like "No kernel headers can be included by userland
anymore" can be slightly misleading.

Miklos
