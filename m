Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wh9pm4lfgzDqLP
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Jun 2017 20:21:52 +1000 (AEST)
In-Reply-To: <20170525033650.10891-9-bsingharora@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: paulus@samba.org, naveen.n.rao@linux.vnet.ibm.com, rashmica.g@gmail.com
Subject: Re: [v1,
 8/8] powerpc/mm/ptdump: Dump the first entry of the linear mapping as
 well
Message-Id: <3wh9pm42fkz9s9Y@ozlabs.org>
Date: Mon,  5 Jun 2017 20:21:52 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-05-25 at 03:36:50 UTC, Balbir Singh wrote:
> The check in hpte_find() should be < and not <= for PAGE_OFFSET
> 
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e63739b1687ea37390e5463f43d054

cheers
