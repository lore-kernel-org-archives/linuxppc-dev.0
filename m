Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ptct3wQvzDr5t
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Aug 2018 21:22:54 +1000 (AEST)
In-Reply-To: <20180322202007.23088-17-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [16/19] powerpc/powermac: Add missing include of header pmac.h
Message-Id: <41ptct30gwz9ryt@ozlabs.org>
Date: Mon, 13 Aug 2018 21:22:54 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-03-22 at 20:20:02 UTC, Mathieu Malaterre wrote:
> The header `pmac.h` was not included, leading to the following warnings,
> treated as error with W=1:
> 
>   arch/powerpc/platforms/powermac/time.c:69:13: error: no previous prototype for ‘pmac_time_init’ [-Werror=missing-prototypes]
>   arch/powerpc/platforms/powermac/time.c:207:15: error: no previous prototype for ‘pmac_get_boot_time’ [-Werror=missing-prototypes]
>   arch/powerpc/platforms/powermac/time.c:222:6: error: no previous prototype for ‘pmac_get_rtc_time’ [-Werror=missing-prototypes]
>   arch/powerpc/platforms/powermac/time.c:240:5: error: no previous prototype for ‘pmac_set_rtc_time’ [-Werror=missing-prototypes]
>   arch/powerpc/platforms/powermac/time.c:259:12: error: no previous prototype for ‘via_calibrate_decr’ [-Werror=missing-prototypes]
>   arch/powerpc/platforms/powermac/time.c:311:13: error: no previous prototype for ‘pmac_calibrate_decr’ [-Werror=missing-prototypes]
> 
> The function `via_calibrate_decr` was made static to silence a warning.
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/2fff0f07b8441a481eb5fc0bfcd0e4

cheers
