Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xbZXv1pVszDqTt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 23:39:11 +1000 (AEST)
In-Reply-To: <20170727062455.15404-3-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [v3, 3/3] powerpc/mm/cxl: Add the fault handling cpu to mm cpumask
Message-Id: <3xbZXv0yxCz9t0F@ozlabs.org>
Date: Mon, 21 Aug 2017 23:39:10 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-07-27 at 06:24:55 UTC, "Aneesh Kumar K.V" wrote:
> We use mm cpumask for serializing against lockless page table walk. Anybody
> who is doing a lockless page table walk is expected to disable irq and only
> cpus in mm cpumask is expected do the lockless walk. This ensure that
> a THP split can send IPI to only cpus in the mm cpumask, to make sure there
> are no parallel lockless page table walk.
> 
> Add the CAPI fault handling cpu to the mm cpumask so that we can do the lockless
> page table walk while inserting hash page table entries.
> 
> Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/0f4bc0932e51817105fdee77a46680

cheers
