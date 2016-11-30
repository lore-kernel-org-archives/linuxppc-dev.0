Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tTKRk0PSpzDvh3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 23:27:14 +1100 (AEDT)
In-Reply-To: <1480385626.11342.53.camel@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: powerpc/mm: Fix lazy icache flush on pre-POWER5
Message-Id: <3tTKRj6bRrz9t2N@ozlabs.org>
Date: Wed, 30 Nov 2016 23:27:13 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-11-29 at 02:13:46 UTC, Benjamin Herrenschmidt wrote:
> On 64-bit CPUs with no-execute support and non-snooping icache, such as
> 970 or POWER4, we have a software mechanism to ensure coherency of the
> cache (using exec faults when needed).
> 
> This was broken due to a logic inversion when that code was rewritten
> from assembly to C.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Fixes: 91f1da99792a1d133df94c4753510305353064a1
> Fixes: 89ff725051d177556b23d80f2a30f880a657a6c1
> Fixes: a43c0eb8364c022725df586e91dd753633374d66
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/dd7b2f035ec41a409f7a7cec7aabc0

cheers
