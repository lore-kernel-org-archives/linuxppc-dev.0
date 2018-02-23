Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zng5R2CN4zF1ky
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 16:39:23 +1100 (AEDT)
In-Reply-To: <20180221130523.27836-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, mwb@linux.vnet.ibm.com,
 nfont@linux.vnet.ibm.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: powerpc/pseries: Fix duplicate firmware feature for DRC_INFO
Message-Id: <3zng5R04dXz9sWm@ozlabs.org>
Date: Fri, 23 Feb 2018 16:39:22 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-02-21 at 13:05:23 UTC, Michael Ellerman wrote:
> We had a mid-air collision between two new firmware features, DRMEM_V2
> and DRC_INFO, and they ended up with the same value.
> 
> No one's actually reported any problems, presumably because the new
> firmware that supports both properties is not widely available, and
> the two properties tend to be enabled together.
> 
> Still if we ever had one enabled but not the other, the bugs that
> could result are many and varied. So fix it.
> 
> Fixes: 3f38000eda48 ("powerpc/firmware: Add definitions for new drc-info firmware feature")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/5539d31a04b3b9ac5f55edb766f1d2

cheers
