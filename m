Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41gMDH4fzczF10S
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2018 15:23:59 +1000 (AEST)
In-Reply-To: <20180705114022.19285-2-akshay.adiga@linux.vnet.ibm.com>
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-pm@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: stewart@linux.vnet.ibm.com, ego@linux.vnet.ibm.com, rjw@rjwysocki.net,
 npiggin@gmail.com, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: Re: [v4,
 1/2] powernv/cpuidle: Parse dt idle properties into global structure
Message-Id: <41gMDH3hWCz9s3x@ozlabs.org>
Date: Wed,  1 Aug 2018 15:23:59 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-07-05 at 11:40:21 UTC, Akshay Adiga wrote:
> Device-tree parsing happens twice, once while deciding idle state to be
> used for hotplug and once during cpuidle init. Hence, parsing the device
> tree and caching it will reduce code duplication. Parsing code has been
> moved to pnv_parse_cpuidle_dt() from pnv_probe_idle_states(). In addition
> to the properties in the device tree the number of available states is
> also required.
> 
> Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9c7b185ab2fe313b4426bf55da3624

cheers
