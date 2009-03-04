Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CB85EDDFD6
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Mar 2009 16:58:22 +1100 (EST)
Subject: Re: ext2_* in bitops.h
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andy Grover <andy.grover@oracle.com>
In-Reply-To: <49AE114C.6070903@oracle.com>
References: <49AE114C.6070903@oracle.com>
Content-Type: text/plain
Date: Wed, 04 Mar 2009 16:58:03 +1100
Message-Id: <1236146283.6696.36.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2009-03-03 at 21:27 -0800, Andy Grover wrote:
> Hi,
> 
> Can the ext2_* definitions in arch/powerpc/include/asm/bitops.h be 
> replaced with:
> 
> #include <include/asm-generic/bitops/ext2-non-atomic.h>
> #include <include/asm-generic/bitops/ext2-atomic.h>
>
> ?
> 
> Also, can the bitop swizzling (starting at line 351) be removed by 
> including include/asm-generic/bitops/le.h? It looks very similar if not 
> identical.
> 
> I'm afraid I don't have a ppc to test on so I wanted to see what you all 
> thought.

I suppose you are right, I'll have a closer look.

Cheers,
Ben.
