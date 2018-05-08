Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40gMsj0VGtzF15H
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2018 00:52:41 +1000 (AEST)
In-Reply-To: <20180501025725.7441-1-bsingharora@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Michael Neuling <mikey@neuling.org>
Subject: Re: [resend] Revert "powerpc/powernv: Increase memory block size to
 1GB on radix"
Message-Id: <40gMsg5h2dz9s35@ozlabs.org>
Date: Wed,  9 May 2018 00:52:39 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-05-01 at 02:57:25 UTC, Balbir Singh wrote:
> This commit was a stop-gap to prevent crashes on hotunplug, caused by
> the mismatch between the 1G mappings used for the linear mapping and the
> memory block size. Those issues are now resolved because we split the
> linear mapping at hotunplug time if necessary, as implemented in commit
> 4dd5f8a99e79 ("powerpc/mm/radix: Split linear mapping on hot-unplug").
> 
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Tested-by: Rashmica Gupta <rashmica.g@gmail.com>
> Tested-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/7acf50e4efa60270edcb95107f660f

cheers
