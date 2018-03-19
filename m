Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 404rDF5fH2zF0xN
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2018 09:22:53 +1100 (AEDT)
In-Reply-To: <20180213195327.GA10678@us.ibm.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, linux-kernel@vger.kernel.org
Subject: Re: Fix cleanup when VAS is not configured
Message-Id: <404rDC6Q1Mz9sWB@ozlabs.org>
Date: Tue, 20 Mar 2018 09:22:50 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-02-13 at 19:53:27 UTC, Sukadev Bhattiprolu wrote:
> From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Date: Fri, 9 Feb 2018 11:49:06 -0600
> Subject: [PATCH 1/1] powerpc/vas: Fix cleanup when VAS is not configured
> 
> When VAS is not configured, unregister the platform driver. Also simplify
> cleanup by delaying vas debugfs init until we know VAS is configured.
> 
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/45ddea8a73a25461387eb8e87f3e0e

cheers
