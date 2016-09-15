Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZswb3f6CzDsYT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 08:07:43 +1000 (AEST)
In-Reply-To: <1473748824-21550-1-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, fbarrat@linux.vnet.ibm.com
Subject: Re: powerpc/powernv: Fix the state of root PE
Message-Id: <3sZswb1mZ1z9stY@ozlabs.org>
Date: Fri, 16 Sep 2016 08:07:43 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-13-09 at 06:40:24 UTC, Gavin Shan wrote:
> The PE for root bus (root PE) can be removed because of PCI hot
> remove in EEH recovery path for fenced PHB error. We need update
> @phb->root_pe_populated accordingly so that the root PE can be
> populated again in forthcoming PCI hot add path. Also, the PE
> shouldn't be destroyed as it's global and reserved resource.
> 
> Fixes: c5f7700bbd2e ("powerpc/powernv: Dynamically release PE")
> Reported-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/6eaed1665fc6864fbdbffcc6f4

cheers
