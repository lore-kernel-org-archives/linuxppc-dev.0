Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x6MMK2pnBzDqhq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 22:48:29 +1000 (AEST)
In-Reply-To: <1499517932.3397.22.camel@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Michael Neuling <michael.neuling@au1.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [1/2] powerpc/mm/radix: Properly clear process table entry
Message-Id: <3x6MMK2H3hz9s8J@ozlabs.org>
Date: Tue, 11 Jul 2017 22:48:29 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2017-07-08 at 12:45:32 UTC, Benjamin Herrenschmidt wrote:
> On radix, the process table entry we want to clear when
> destroying a context is entry 0, not entry 1
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/c6bb0b8d426a8cf865ca9c8a532cc3

cheers
