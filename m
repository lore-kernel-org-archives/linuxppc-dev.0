Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vDdTj2XCPzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2017 22:45:13 +1100 (AEDT)
In-Reply-To: <20170112101734.5608-1-anton@ozlabs.org>
To: Anton Blanchard <anton@ozlabs.org>, benh@kernel.crashing.org,
 paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [1/2] powerpc/64: Move HAVE_CONTEXT_TRACKING from pseries to
 common Kconfig
Message-Id: <3vDdTj1zvsz9s7L@ozlabs.org>
Date: Thu,  2 Feb 2017 22:45:13 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-01-12 at 10:17:33 UTC, Anton Blanchard wrote:
> From: Anton Blanchard <anton@samba.org>
> 
> We added support for HAVE_CONTEXT_TRACKING, but placed the option inside
> PPC_PSERIES.
> 
> This has the undesirable effect that NO_HZ_FULL can be enabled on a
> kernel with both powernv and pseries support, but cannot on a kernel
> with powernv only support.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d6c569b99558b219fcf0ce0d3af8ec

cheers
