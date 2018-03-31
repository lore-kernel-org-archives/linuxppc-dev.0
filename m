Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40D0Zw2skczF1sR
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Apr 2018 01:03:52 +1100 (AEDT)
In-Reply-To: <20180213150824.27689-2-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [01/14] powerpc/64s: do not allocate lppaca if we are not
 virtualized
Message-Id: <40D0Zt3Kdcz9s1S@ozlabs.org>
Date: Sun,  1 Apr 2018 01:03:48 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-02-13 at 15:08:11 UTC, Nicholas Piggin wrote:
> The "lppaca" is a structure registered with the hypervisor. This
> is unnecessary when running on non-virtualised platforms. One field
> from the lppaca (pmcregs_in_use) is also used by the host, so move
> the host part out into the paca (lppaca field is still updated in
> guest mode).
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8e0b634b132752ec3eba50afb95250

cheers
