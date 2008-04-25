Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7A2D5DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 17:28:52 +1000 (EST)
Date: Fri, 25 Apr 2008 09:23:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC][WIP][PATCH] Add IRQSTACKS to ppc32
Message-ID: <20080425072332.GB23053@lst.de>
References: <Pine.LNX.4.64.0804240034160.23185@blarg.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0804240034160.23185@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 24, 2008 at 12:37:50AM -0500, Kumar Gala wrote:
>  config IRQSTACKS
>  	bool "Use separate kernel stacks when processing interrupts"
> -	depends on PPC64

Why do we have this as a user-selectable option?  It should be on by
default on 32 or 64bit.
