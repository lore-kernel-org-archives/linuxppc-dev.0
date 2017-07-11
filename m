Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x6MMJ4N7czDqgQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 22:48:28 +1000 (AEST)
In-Reply-To: <1499461936.3397.13.camel@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc dev list <linuxppc-dev@lists.ozlabs.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Michael Neuling <michael.neuling@au1.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nick Piggin <npiggin@au1.ibm.com>
Subject: Re: [2/2] powerpc/mm/radix: Synchronize updates to the process table
Message-Id: <3x6MMJ3j2Cz9t0j@ozlabs.org>
Date: Tue, 11 Jul 2017 22:48:28 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-07-07 at 21:12:16 UTC, Benjamin Herrenschmidt wrote:
> When writing to the process table, we need to ensure the store is
> visible to a subsequent access by the MMU. We assume we never have
> the PID active while doing the update, so a ptesync/isync pair
> should hopefully be a big enough hammer for our purpose.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/3a6a04706fd08eb5677fdfc086e26f

cheers
