Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xQvGl1NcDzDqnn
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Aug 2017 20:41:51 +1000 (AEST)
In-Reply-To: <20170719044907.21703-1-benh@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [v2,
 1/4] powerpc/mm/radix: Improve _tlbiel_pid to be usable for PWC
 flushes
Message-Id: <3xQvGl00QXz9t2S@ozlabs.org>
Date: Mon,  7 Aug 2017 20:41:50 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-07-19 at 04:49:04 UTC, Benjamin Herrenschmidt wrote:
> The PWC flush only needs a single set call, just like the
> full (RIC=2) flush.
> 
> This will allow us to get rid of the dedicated _tlbiel_pwc()
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/5ce5fe14ed0302315061cf97ce67ac

cheers
