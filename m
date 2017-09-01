Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xkKpz6kWdzDqfx
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Sep 2017 23:29:47 +1000 (AEST)
In-Reply-To: <20170629071256.8159-2-oohall@gmail.com>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: mikey@neuling.org, Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [1/4] powerpc/smp: Use cpu_to_chip_id() to find core siblings
Message-Id: <3xkKpz5Mmcz9s7F@ozlabs.org>
Date: Fri,  1 Sep 2017 23:29:47 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-06-29 at 07:12:53 UTC, Oliver O'Halloran wrote:
> When building the CPU scheduler topology the kernel uses the ibm,chipid
> property from the devicetree to group logical CPUs. Currently the DT
> search for this property is open-coded in smp.c and this functionality
> is a duplication of what's in cpu_to_chip_id() already. This patch
> removes the existing search in favor of that.
> 
> It's worth mentioning that the semantics of the search are different
> in cpu_to_chip_id(). When there is no ibm,chipid in the CPUs node it
> will also search /cpus and / for the property, but this should not
> effect the output topology.
> 
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e3d8b67e2c60dcd35661d34df249f2

cheers
