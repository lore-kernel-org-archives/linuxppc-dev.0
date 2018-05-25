Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40skq51pwzzF1kY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 21:41:21 +1000 (AEST)
In-Reply-To: <20180322202007.23088-9-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [08/19] powerpc/tau: Make some function static
Message-Id: <40skq50bx1z9s1d@ozlabs.org>
Date: Fri, 25 May 2018 21:41:21 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-03-22 at 20:19:54 UTC, Mathieu Malaterre wrote:
> These functions can all be static, make it so. Fix warnings treated as
> errors with W=1:
> 
>   arch/powerpc/kernel/tau_6xx.c:53:6: error: no previous prototype for ‘set_thresholds’ [-Werror=missing-prototypes]
>   arch/powerpc/kernel/tau_6xx.c:73:6: error: no previous prototype for ‘TAUupdate’ [-Werror=missing-prototypes]
>   arch/powerpc/kernel/tau_6xx.c:208:13: error: no previous prototype for ‘TAU_init_smp’ [-Werror=missing-prototypes]
>   arch/powerpc/kernel/tau_6xx.c:220:12: error: no previous prototype for ‘TAU_init’ [-Werror=missing-prototypes]
>   arch/powerpc/kernel/tau_6xx.c:126:6: error: no previous prototype for ‘TAUException’ [-Werror=missing-prototypes]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9e0d86cd2d749998c3792059221cef

cheers
