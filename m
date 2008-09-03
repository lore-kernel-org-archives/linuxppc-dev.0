Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5F8EFDDE1E
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Sep 2008 10:59:38 +1000 (EST)
Subject: Re: [PATCH] powerpc: Reserve syscall number 319
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20080902234635.GA863@lst.de>
References: <20080902054941.77DA3DDDF0@ozlabs.org>
	<20080902180605.GA8240@lixom.net> <1220389575.13010.149.camel@pasglop>
	<20080902234635.GA863@lst.de>
Content-Type: text/plain
Date: Wed, 03 Sep 2008 10:58:42 +1000
Message-Id: <1220403522.13010.189.camel@pasglop>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-09-03 at 01:46 +0200, Christoph Hellwig wrote:
> On Wed, Sep 03, 2008 at 07:06:15AM +1000, Benjamin Herrenschmidt wrote:
> > > Yes. Merge your code or live with the pain of things changing
> > > underneath. Period.
> > 
> > Pain isn't for me :-) It's for those writing userspace stuff based on
> > my kernel changing all the time :-)
> 
> They can wait until it's released.  And there's of course no guarantee
> that your syscall will stand public review.

Yup. Definitely. I'm not even 100% sure we'll stick to a syscall in
the long run. In the meantime, for internal purposes, it's easy enough
to use an unused number to avoid further changes or stick a trampoline
in the vdso :-)

Cheers,
Ben.
