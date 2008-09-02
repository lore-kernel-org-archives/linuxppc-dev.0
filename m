Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F3A04DDF3E
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Sep 2008 09:48:20 +1000 (EST)
Date: Wed, 3 Sep 2008 01:46:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Reserve syscall number 319
Message-ID: <20080902234635.GA863@lst.de>
References: <20080902054941.77DA3DDDF0@ozlabs.org>
	<20080902180605.GA8240@lixom.net>
	<1220389575.13010.149.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1220389575.13010.149.camel@pasglop>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 03, 2008 at 07:06:15AM +1000, Benjamin Herrenschmidt wrote:
> > Yes. Merge your code or live with the pain of things changing
> > underneath. Period.
> 
> Pain isn't for me :-) It's for those writing userspace stuff based on
> my kernel changing all the time :-)

They can wait until it's released.  And there's of course no guarantee
that your syscall will stand public review.
