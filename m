Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40skq61cZDzF1kY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 21:41:22 +1000 (AEST)
In-Reply-To: <20180322202007.23088-11-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [10/19] powerpc/chrp/time: Make some functions static,
 add missing header include
Message-Id: <40skq60ynBz9s2R@ozlabs.org>
Date: Fri, 25 May 2018 21:41:21 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-03-22 at 20:19:56 UTC, Mathieu Malaterre wrote:
> Add a missing include <platforms/chrp/chrp.h>.
> 
> These functions can all be static, make it so. Fix warnings treated as
> errors with W=1:
> 
>   arch/powerpc/platforms/chrp/time.c:41:13: error: no previous prototype for ‘chrp_time_init’ [-Werror=missing-prototypes]
>   arch/powerpc/platforms/chrp/time.c:66:5: error: no previous prototype for ‘chrp_cmos_clock_read’ [-Werror=missing-prototypes]
>   arch/powerpc/platforms/chrp/time.c:74:6: error: no previous prototype for ‘chrp_cmos_clock_write’ [-Werror=missing-prototypes]
>   arch/powerpc/platforms/chrp/time.c:86:5: error: no previous prototype for ‘chrp_set_rtc_time’ [-Werror=missing-prototypes]
>   arch/powerpc/platforms/chrp/time.c:130:6: error: no previous prototype for ‘chrp_get_rtc_time’ [-Werror=missing-prototypes]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b87a358b4a1421abd544c0b554b1b7

cheers
