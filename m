Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40skqF4KLjzF1wr
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 21:41:29 +1000 (AEST)
In-Reply-To: <20180404200911.27506-1-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [v3,
 05/19] powerpc/chrp/setup: Remove idu_size variable and make some
 functions static
Message-Id: <40skqD3Yvlz9s2k@ozlabs.org>
Date: Fri, 25 May 2018 21:41:27 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-04-04 at 20:09:11 UTC, Mathieu Malaterre wrote:
> Remove variable declaration idu_size and associated code since not used.
> 
> These functions can all be static, make it so. Fix warnings treated as
> errors with W=1:
> 
>   arch/powerpc/platforms/chrp/setup.c:97:6: error: no previous prototype for ‘chrp_show_cpuinfo’ [-Werror=missing-prototypes]
>   arch/powerpc/platforms/chrp/setup.c:302:13: error: no previous prototype for ‘chrp_setup_arch’ [-Werror=missing-prototypes]
>   arch/powerpc/platforms/chrp/setup.c:385:16: error: variable ‘idu_size’ set but not used [-Werror=unused-but-set-variable]
>   arch/powerpc/platforms/chrp/setup.c:526:13: error: no previous prototype for ‘chrp_init_IRQ’ [-Werror=missing-prototypes]
>   arch/powerpc/platforms/chrp/setup.c:559:1: error: no previous prototype for ‘chrp_init2’ [-Werror=missing-prototypes]
> 
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f0e0b86638e9df6731b1d61c71ae18

cheers
