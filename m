Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8A3D5DDF58
	for <linuxppc-dev@ozlabs.org>; Sun, 26 Apr 2009 04:27:37 +1000 (EST)
Date: Sat, 25 Apr 2009 20:18:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 1/6] powerpc: Move #ifdef'ed body of do_IRQ() into a
	separate function
Message-ID: <20090425181823.GA10481@lst.de>
References: <c3e0e417a708c5d76d9f4130e5f2b0398a1e0c3e.1240450296.git.michael@ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c3e0e417a708c5d76d9f4130e5f2b0398a1e0c3e.1240450296.git.michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 23, 2009 at 11:31:37AM +1000, Michael Ellerman wrote:
> +#ifdef CONFIG_IRQSTACKS

Wasn't there a plan to make CONFIG_IRQSTACKS the unconditional default?


The actual patch looks good to me.
