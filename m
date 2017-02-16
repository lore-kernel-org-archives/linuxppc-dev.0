Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vP58g1lwMzDqBW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 16:59:47 +1100 (AEDT)
In-Reply-To: <20170202050344.6825-2-bsingharora@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [1/3] powerpc/xmon Update ppc-dis/opc.c and ppc.h
Message-Id: <3vP58g0L6lz9s9r@ozlabs.org>
Date: Thu, 16 Feb 2017 16:59:46 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-02-02 at 05:03:42 UTC, Balbir Singh wrote:
> Upgrade ppc-opc.c, ppc-dis.c and ppc.h to the
> versions belonging to the following commit
> 
> 65b650b4c7463f4508bed523c24ab0031a5ae5cd
> * ppc-dis.c (print_insn_powerpc): Don't skip all operands
>   after setting skip_optional.
> 
> This version will not compile, but make it easier to
> apply newer reclicensed commits on top of
> 
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/cc7639ce18b950086c7b06e0035065

cheers
