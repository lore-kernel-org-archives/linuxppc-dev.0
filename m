Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17209.817.732159.375607@cargo.ozlabs.ibm.com>
References: <17208.37250.577664.621993@cargo.ozlabs.ibm.com>
	<20050927082324.GA11437@lst.de>
	<17209.817.732159.375607@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Wed, 28 Sep 2005 10:05:14 +1000
Message-Id: <1127865914.6102.0.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: Re: Starting the arch/powerpc merge
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2005-09-27 at 18:30 +1000, Paul Mackerras wrote:
> Christoph Hellwig writes:
> 
> > What about just dropping POWER3/4 support in 32bit mode?
> 
> Yes... I'm getting very close to deciding to do that.  In fact POWER3
> isn't too bad, since it still has BATs, but POWER4/PPC970 would be
> tricky.
> 
> Does anyone on these lists have any major objections if we drop
> support for 32-bit kernels on POWER3 and POWER4/PPC970?

I've stopped supporting G5 on 32 bits kernel for some time now, I have
absolutely no problem just dropping the POWER4 support in 32 bits kernel
in the merged tree.

Ben.
