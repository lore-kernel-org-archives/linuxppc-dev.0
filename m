Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401RHS2HbnzDqjw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 20:28:52 +1100 (AEDT)
In-Reply-To: <20180308025442.6165-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: npiggin@gmail.com
Subject: Re: [1/4] powerpc/pseries: Move smp_query_cpu_stopped() etc. out of
 plpar_wrappers.h
Message-Id: <401RHQ5WVNz9sVv@ozlabs.org>
Date: Wed, 14 Mar 2018 20:28:48 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-03-08 at 02:54:39 UTC, Michael Ellerman wrote:
> smp_query_cpu_stopped() and related #defines are currently in
> plpar_wrappers.h. The function actually does an RTAS call, not an
> hcall, and basically has nothing to do with plpar_wrappers.h
> 
> Move it into pseries.h, where it can easily be used by the only two
> callers in pseries/smp.c and pseries/hotplug-cpu.c.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Series applied to powerpc next.

https://git.kernel.org/powerpc/c/16560e88320d276036b393d4ba51cf

cheers
