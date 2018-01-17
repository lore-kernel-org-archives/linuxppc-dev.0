Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zM7Hk2ksJzF0bc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jan 2018 00:30:10 +1100 (AEDT)
In-Reply-To: <20171215081455.11941-1-bsingharora@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: npiggin@gmail.com
Subject: Re: [v4, 1/2] powerpc/crash: Remove the test for cpu_online in the IPI
 callback
Message-Id: <3zM7Hj29xVz9t2c@ozlabs.org>
Date: Thu, 18 Jan 2018 00:30:08 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-12-15 at 08:14:54 UTC, Balbir Singh wrote:
> Our check was extra cautious, we've audited crash_send_ipi
> and it sends an IPI only to online CPU's. Removal of this
> check should have not functional impact on crash kdump.
> 
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/04b9c96eae72d862726f2f4bfcec20

cheers
