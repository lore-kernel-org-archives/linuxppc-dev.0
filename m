Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yCBM01ZHLzDr67
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Oct 2017 11:20:12 +1100 (AEDT)
In-Reply-To: <20171010064530.19276-1-sandipan@linux.vnet.ibm.com>
To: Sandipan Das <sandipan@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, naveen.n.rao@linux.vnet.ibm.com,
 paulus@samba.org, anton@samba.org
Subject: Re: [v2] powerpc/lib/sstep: Fix count leading zeros instructions
Message-Id: <3yCBLz6ndfz9t2c@ozlabs.org>
Date: Thu, 12 Oct 2017 11:20:11 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-10-10 at 06:45:30 UTC, Sandipan Das wrote:
> According to the GCC documentation, the behaviour of __builtin_clz()
> and __builtin_clzl() is undefined if the value of the input argument
> is zero. Without handling this special case, these builtins have been
> used for emulating the following instructions:
>   * Count Leading Zeros Word (cntlzw[.])
>   * Count Leading Zeros Doubleword (cntlzd[.])
> 
> This fixes the emulated behaviour of these instructions by adding an
> additional check for this special case.
> 
> Fixes: 3cdfcbfd32b9d ("powerpc: Change analyse_instr so it doesn't modify *regs")
> Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
> Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/b0490a04e736356e427e227902b17f

cheers
