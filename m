Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 50C82DDF35
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 17:32:57 +1000 (EST)
Date: Fri, 25 Jul 2008 09:32:25 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: sfx.c driver build failure
Message-ID: <20080725073225.GB21824@elte.hu>
References: <1216966559.11188.85.camel@pasglop>
	<20080725171715.9287c823.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20080725171715.9287c823.sfr@canb.auug.org.au>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Michael Brown <mbrown@fensystems.co.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> On Fri, 25 Jul 2008 16:15:59 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >
> > The sfx driver (which happens to be part of some of our test configs)
> > fails to build in current Linus tree on powerpc with this error:
> > 
> > /home/benh/kernels/linux-powerpc/drivers/net/sfc/efx.c: In function ‘efx_probe_interrupts’:
> > /home/benh/kernels/linux-powerpc/drivers/net/sfc/efx.c:845: error: lvalue required as unary ‘&’ operand
> 
> Commit 695a6b456307455a10059512208e8ed0d376ecd3 "topology: work around 
> topology_core_siblings() breakage" in linux-next (from the cpus4096 
> tree) comments out the offending lines ...  With the comment "the 
> topology API is a mess right now".

there's a patch from Mike Travis that solves it all from grounds up and 
which approach has the ack of Rusty as well, but it's not fully tested 
through yet - i will get to it later today.

	Ingo
