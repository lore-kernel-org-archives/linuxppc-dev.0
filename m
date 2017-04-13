Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3dh72PYJzDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 21:23:19 +1000 (AEST)
In-Reply-To: <20170331013749.17874-1-oohall@gmail.com>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Rashmica Gupta <rashmica.g@gmail.com>, Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [1/2] powerpc/mm: fix up pgtable dump flags
Message-Id: <3w3dh716qbz9sNW@ozlabs.org>
Date: Thu, 13 Apr 2017 21:23:19 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-03-31 at 01:37:48 UTC, Oliver O'Halloran wrote:
> On Book3s we have two PTE flags used to mark cache-inhibited mappings:
> _PAGE_TOLERANT and _PAGE_NON_IDEMPOTENT. Currently the kernel page
> table dumper only looks at the generic _PAGE_NO_CACHE which is
> defined to be _PAGE_TOLERANT. This patch modifies the dumper so
> both flags are shown in the dump.
> 
> Cc: Rashmica Gupta <rashmica.g@gmail.com>
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/70538eaa70c36340b4bb27206cad31

cheers
