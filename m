Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40skqK1svyzF1sg
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 21:41:33 +1000 (AEST)
In-Reply-To: <20180404201230.27756-1-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [v3,13/19] powerpc/52xx: Add missing functions prototypes
Message-Id: <40skqJ4Wr0z9s32@ozlabs.org>
Date: Fri, 25 May 2018 21:41:32 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-04-04 at 20:12:30 UTC, Mathieu Malaterre wrote:
> The function prototypes were declared within a `#ifdef CONFIG_PPC_LITE5200`
> block which would prevent them from being visible when compiling
> `mpc52xx_pm.c`. Move the prototypes outside of the `#ifdef` block to fix
> the following warnings treated as errors with W=1:
> 
>   arch/powerpc/platforms/52xx/mpc52xx_pm.c:58:5: error: no previous prototype for ‘mpc52xx_pm_prepare’ [-Werror=missing-prototypes]
>   arch/powerpc/platforms/52xx/mpc52xx_pm.c:113:5: error: no previous prototype for ‘mpc52xx_pm_enter’ [-Werror=missing-prototypes]
>   arch/powerpc/platforms/52xx/mpc52xx_pm.c:181:6: error: no previous prototype for ‘mpc52xx_pm_finish’ [-Werror=missing-prototypes]
> 
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c3f0515ea1277558e7c0c3240d17c7

cheers
