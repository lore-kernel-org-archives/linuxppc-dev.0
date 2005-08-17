Return-Path: <SRS0+012e81371fdbb5a82166+724+infradead.org+hch@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5F74C67FC1
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Aug 2005 19:20:49 +1000 (EST)
Date: Wed, 17 Aug 2005 10:20:41 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Message-ID: <20050817092041.GA12910@infradead.org>
References: <20050816.203312.77701192.davem@davemloft.net>
	<032E6AED-9456-4271-9B06-C5DCE5970193@freescale.com>
	<20050817083048.GA11892@infradead.org>
	<E1E5Jii-0004Yc-00@dorka.pomaz.szeredi.hu>
	<20050817090920.GA12716@infradead.org>
	<E1E5K1L-0004bH-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1E5K1L-0004bH-00@dorka.pomaz.szeredi.hu>
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

On Wed, Aug 17, 2005 at 11:15:39AM +0200, Miklos Szeredi wrote:
> They are provided by _one_ kernel, not necessarily the running kernel.

No, they're provided by packages like glibc-kernheaders or similar
that are maintained separately.  They're split from the kernel headers
and we don't need to keep obsolete junk around.
