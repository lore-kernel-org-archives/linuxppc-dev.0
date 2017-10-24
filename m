Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yLm9h4ryJzDqmc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 19:08:24 +1100 (AEDT)
In-Reply-To: <1507546772-31932-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/xmon: Add kstack base to paca dump
Message-Id: <3yLm9h3Qmhz9s9Y@ozlabs.org>
Date: Tue, 24 Oct 2017 19:08:23 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-10-09 at 10:59:32 UTC, Michael Ellerman wrote:
> When dumping the paca in xmon we currently show kstack. Although it's
> not hard it's a bit fiddly to work out what the bounds of the kernel
> stack should be based on the kstack value.
> 
> To make life easier and "kstack_base" which is the base (lowest
> address) of the kernel stack, eg:
> 
>  kstack               = 0xc0000000f1a7be30      (0x258)
>  kstack_base          = 0xc0000000f1a78000
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/90d6473747b289739b435d5fa6ae8e

cheers
