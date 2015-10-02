Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6332B1A04D3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 17:47:09 +1000 (AEST)
In-Reply-To: <1443153700-15395-3-git-send-email-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>, benh@kernel.crashing.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org, Aaron Sawdey <sawdey@us.ibm.com>,
 Denis Kirjanov <kda@linux-powerpc.org>, Steve Munroe <sjmunroe@us.ibm.com>,
 linuxppc-dev@ozlabs.org, anton@samba.org
Subject: Re: [v2,
 2/2] powerpc/vdso: Avoid link stack corruption in __get_datapage()
Message-Id: <20151002074709.3AE4F140773@ozlabs.org>
Date: Fri,  2 Oct 2015 17:47:09 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-25-09 at 04:01:40 UTC, Michael Neuling wrote:
> powerpc has a link register (lr) used for calling functions. We "bl
> <func>" to call a function, and "blr" to return back to the call site.

<snip, geez that was long>

> For the benchmark in tools/testing/selftests/powerpc/benchmarks/gettimeofday.c
>   POWER8:
>     64bit gets ~4% improvement
>     32bit gets ~9% improvement
>   POWER7:
>     64bit gets ~7% improvement
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Reported-by: Aaron Sawdey <sawdey@us.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c974809a26a13e40254dbe3c

cheers
