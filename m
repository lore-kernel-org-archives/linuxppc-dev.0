Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40GTBf0fNWzF1lS
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Apr 2018 00:39:54 +1000 (AEST)
In-Reply-To: <20180401103615.15454-2-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [v2,1/3] powerpc: use NMI IPI for smp_send_stop
Message-Id: <40GTBd5rg3z9s2Y@ozlabs.org>
Date: Thu,  5 Apr 2018 00:39:53 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2018-04-01 at 10:36:13 UTC, Nicholas Piggin wrote:
> Use the NMI IPI rather than smp_call_function for smp_send_stop.
> Have stopped CPUs hard disable interrupts rather than just soft
> disable.
> 
> This function is used in crash/panic/shutdown paths to bring other
> CPUs down as quickly and reliably as possible, and minimizing their
> potential to cause trouble.
> 
> Avoiding the Linux smp_call_function infrastructure and (if supported)
> using true NMI IPIs makes this more robust.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6bed3237624e3faad1592543952907

cheers
