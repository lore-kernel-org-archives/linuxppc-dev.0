Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C930ADDED6
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2008 10:44:43 +1000 (EST)
Subject: Re: new warnings from stacktrace patch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20080423143229.GA18667@lst.de>
References: <20080423175938.a4b3cc26.sfr@canb.auug.org.au>
	<20080423143229.GA18667@lst.de>
Content-Type: text/plain
Date: Thu, 24 Apr 2008 10:44:21 +1000
Message-Id: <1208997861.9060.79.camel@pasglop>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Paul Mackerras <paulus@samba.org>,
	ppc-dev <linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-04-23 at 16:32 +0200, Christoph Hellwig wrote:
> On Wed, Apr 23, 2008 at 05:59:38PM +1000, Stephen Rothwell wrote:
> > This is from commit fd3e0bbc6052ca9747a5332b382584ece83aab6d ("[POWERPC]
> > Stacktrace support for lockdep").  We don't include asm-offsets.h in any
> > other C file in the powerpc build.
> 
> I think the include can be safely removed.

Yup. It's a leftover from before I fixed up some stuff in ptrace.h

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Ack.

> Index: linux-2.6/arch/powerpc/kernel/stacktrace.c
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/kernel/stacktrace.c	2008-04-23 15:28:05.000000000 +0200
> +++ linux-2.6/arch/powerpc/kernel/stacktrace.c	2008-04-23 15:28:16.000000000 +0200
> @@ -13,7 +13,6 @@
>  #include <linux/sched.h>
>  #include <linux/stacktrace.h>
>  #include <asm/ptrace.h>
> -#include <asm/asm-offsets.h>
>  
>  /*
>   * Save stack-backtrace addresses into a stack_trace buffer.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
