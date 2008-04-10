Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 1172FDF004
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 08:16:18 +1000 (EST)
Date: Thu, 10 Apr 2008 15:16:16 -0700 (PDT)
Message-Id: <20080410.151616.204291886.davem@davemloft.net>
To: laurentp@cse-semaphore.com
Subject: Re: patches for 2.6.26
From: David Miller <davem@davemloft.net>
In-Reply-To: <200804101720.36975.laurentp@cse-semaphore.com>
References: <D9A4BB4A-970C-4E9E-9174-BA8C0191CCA2@kernel.crashing.org>
	<200804101720.36975.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Laurent Pinchart <laurentp@cse-semaphore.com>
Date: Thu, 10 Apr 2008 17:20:36 +0200

> On Thursday 10 April 2008 16:21, Kumar Gala wrote:
> > Guy's
> > 
> > if you have work you want in 2.6.26 related to Freescale PPC's let me  
> > know.  Ideally you can provide links to the patches in
> > http://patchwork.ozlabs.org/linuxppc/ 
> 
> Could you please add this one ?
> 
> fs_enet: Don't call NAPI functions when NAPI is not used.
> http://patchwork.ozlabs.org/linuxppc/patch?id=17055

I kindly request that PPC folks send networking driver patches through
the normal channels so that the networking experts on netdev and
people like Jeff Garzik can review such changes.

In fact this patch here is a bug fix and belongs in the tree right
now, instead of waiting for 2.6.26
