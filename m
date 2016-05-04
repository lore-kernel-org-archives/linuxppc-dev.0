Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r0Y0C0qmyzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 May 2016 08:40:27 +1000 (AEST)
In-Reply-To: <1462258767-83025-1-git-send-email-valentinrothberg@gmail.com>
To: Valentin Rothberg <valentinrothberg@gmail.com>,
 aneesh.kumar@linux.vnet.ibm.com
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Valentin Rothberg <valentinrothberg@gmail.com>
Subject: Re: powerpc/mm/radix: fix STD_MMU_64 typo
Message-Id: <3r0Y0B6J1xz9t5C@ozlabs.org>
Date: Thu,  5 May 2016 08:40:26 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-03-05 at 06:59:27 UTC, Valentin Rothberg wrote:
> s/MMU_STD_64/STD_MMU_64/
> 
> Fixes: 11ffc1cfa4c2 ("powerpc/mm/radix: Use STD_MMU_64 to properly
>                       isolate hash related code")
> Signed-off-by: Valentin Rothberg <valentinrothberg@gmail.com>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ce7da681b8fdb374a401652a93

cheers
