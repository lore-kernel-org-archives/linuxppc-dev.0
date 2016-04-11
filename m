Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qk8fY6KcVzDqBG
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 22:35:17 +1000 (AEST)
In-Reply-To: <1455860327-22913-1-git-send-email-rashmicy@gmail.com>
To: Rashmica Gupta <rashmicy@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [V2] powerpc/Kconfig: Update config option based on page size.
Message-Id: <3qk8fY48r6z9t45@ozlabs.org>
Date: Mon, 11 Apr 2016 22:35:17 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-19-02 at 05:38:47 UTC, Rashmica Gupta wrote:
> Currently on PPC64 changing kernel pagesize from 4K to 64K leaves
> FORCE_MAX_ZONEORDER set to 13 - which produces a compile error.
> 
...
> So, update the range of FORCE_MAX_ZONEORDER from 9-64 to 8-9 for 64K pages
> and from 13-64 to 9-13 for 4K pages.
> 
> Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
> Reviewed-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a7ee539584acf4a565b7439cea

cheers
