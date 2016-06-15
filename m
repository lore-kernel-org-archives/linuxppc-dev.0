Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rV5g32bL3zDqnk
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 22:39:11 +1000 (AEST)
In-Reply-To: <1464589095-442-1-git-send-email-rashmicy@gmail.com>
To: Rashmica Gupta <rashmicy@gmail.com>, benh@kernel.crashing.org,
 paulus@samba.org, nfont@linux.vnet.ibm.com
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [1/5] powerpc/pseries: Drop support for MPIC in pseries
Message-Id: <3rV5g30WWyz9t1l@ozlabs.org>
Date: Wed, 15 Jun 2016 22:39:11 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-30-05 at 06:18:11 UTC, Rashmica Gupta wrote:
> MPIC was only used by Power3 which is now unsupported, so drop support
> for MPIC. XICS is now the only supported interrupt controller for
> pSeries so make the XICS functions generic.
> 
> Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e7da5dac4e9067a526136db2f2

cheers
