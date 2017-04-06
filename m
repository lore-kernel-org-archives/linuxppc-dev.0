Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzNHs30ZYzDqJL
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Apr 2017 23:06:01 +1000 (AEST)
In-Reply-To: <149070869902.18309.14355142133222424050.stgit@jupiter.in.ibm.com>
To: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [1/2] powerpc/book3s: Display more info for MCE error console log.
Message-Id: <3vzNHs1wPhz9s8N@ozlabs.org>
Date: Thu,  6 Apr 2017 23:06:01 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-03-28 at 13:45:04 UTC, Mahesh Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> For D-side errors we print data load/store address as 'Effective address'
> that caused MC. In addition to print NIP, print kernel function name as well.
> 
> After this patch the MCE console log would look like:
> 
> [  291.444281] Severe Machine check interrupt [Recovered]
> [  291.444477]   NIP [d00000001bc70194]: init_module+0x194/0x2b0 [bork_kernel]
> [  291.444707]   Initiator: CPU
> [  291.444761]   Error type: SLB [Parity]
> [  291.444793]     Effective address: d000000026de0000
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/5b1d6fc2d4d927852214f2a7e2a8eb

cheers
