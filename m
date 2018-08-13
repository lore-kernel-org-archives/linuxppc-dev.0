Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ptd73n3rzF0WK
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Aug 2018 21:23:07 +1000 (AEST)
In-Reply-To: <20180622192655.23464-1-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc: include setup.h header file to fix warnings
Message-Id: <41ptd71wjhz9sBJ@ozlabs.org>
Date: Mon, 13 Aug 2018 21:23:07 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-06-22 at 19:26:53 UTC, Mathieu Malaterre wrote:
> Make sure to include setup.h to provide the following prototypes:
> 
> - irqstack_early_init
> - setup_power_save
> - initialize_cache_info
> 
> Fix the following warnings (treated as error in W=1):
> 
>   arch/powerpc/kernel/setup_32.c:198:13: error: no previous prototype for ‘irqstack_early_init’ [-Werror=missing-prototypes]
>   arch/powerpc/kernel/setup_32.c:238:13: error: no previous prototype for ‘setup_power_save’ [-Werror=missing-prototypes]
>   arch/powerpc/kernel/setup_32.c:253:13: error: no previous prototype for ‘initialize_cache_info’ [-Werror=missing-prototypes]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f2c6d0d1092e3da2bd36c768777e88

cheers
