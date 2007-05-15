Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2501CDDE35
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 06:42:21 +1000 (EST)
Subject: Re: [RFC/PATCH] powerpc: Rewrite IO allocation & mapping on powerpc64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20070515105635.GA1258@lst.de>
References: <20070514075415.7999BDDEC8@ozlabs.org>
	<20070515105635.GA1258@lst.de>
Content-Type: text/plain
Date: Wed, 16 May 2007 06:42:11 +1000
Message-Id: <1179261731.32247.193.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-05-15 at 12:56 +0200, Christoph Hellwig wrote:
> Some comments:
> 
>  - the comment above __iounmap_at needs some updates
>  - instead of the fake vm_struct in __iounmap_at just changed the
>    calling conventions for unmap_vm_area to take a start and len
>    value - there's only two callers including the powerpc ioremap
>    code for this.  At the same time it might also get a better name.

Yeah, good idea, I'll have a look.

Ben.
