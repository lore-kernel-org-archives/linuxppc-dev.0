Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zxgl0KzJzF0kx
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 00:11:31 +1000 (AEST)
In-Reply-To: <20180601082402.17192-1-aneesh.kumar@linux.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, benh@kernel.crashing.org,
 paulus@samba.org, npiggin@gmail.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/mm/hash: hard disable irq in the SLB insert path
Message-Id: <40zxgk3kS9z9s1w@ozlabs.org>
Date: Tue,  5 Jun 2018 00:11:29 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-06-01 at 08:24:02 UTC, "Aneesh Kumar K.V" wrote:
> When inserting SLB entries for EA above 512TB, we need to hard disable irq.
> This will make sure we don't take a PMU interrupt that can possibly touch
> user space address via a stack dump. To prevent this, we need to hard disable
> the interrupt.
> 
> Also add a comment explaining why we don't need context synchronizing isync
> with slbmte.
> 
> Fixes: f384796c4 ("powerpc/mm: Add support for handling > 512TB address in SLB miss")
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a5db5060e0b2e27605df272224bfd4

cheers
