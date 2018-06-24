Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 41D9FK5crFzF0Pd
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jun 2018 21:34:29 +1000 (AEST)
Date: Sun, 24 Jun 2018 21:35:18 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Michael Schmitz <schmitzmic@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/12] macintosh: Resolve various PMU driver
 problems
In-Reply-To: <cover.1528885172.git.fthain@telegraphics.com.au>
Message-ID: <alpine.LNX.2.21.1806242119180.34@nippy.intranet>
References: <cover.1528885172.git.fthain@telegraphics.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 13 Jun 2018, I wrote:

> Finn Thain (12):
>   macintosh/via-pmu: Fix section mismatch warning
>   macintosh/via-pmu: Add missing mmio accessors
>   macintosh/via-pmu: Don't clear shift register interrupt flag twice
>   macintosh/via-pmu: Enhance state machine with new 'uninitialized'
>     state
>   macintosh/via-pmu: Replace via pointer with via1 and via2 pointers
>   macintosh/via-pmu: Add support for m68k PowerBooks
>   macintosh/via-pmu: Make CONFIG_PPC_PMAC Kconfig deps explicit
>   macintosh/via-pmu68k: Don't load driver on unsupported hardware
>   macintosh/via-pmu: Replace via-pmu68k driver with via-pmu driver
>   macintosh: Use common code to access RTC
>   macintosh/via-pmu: Clean up interrupt statistics
>   macintosh/via-pmu: Disambiguate interrupt statistics
> 

Patch 10/12 ("macintosh: Use common code to access RTC") conflicts with 
Arnd's RTC work, but the rest of this series can still be reviewed and 
merged as-is.

I will rewrite patch 10/12 after Arnd's fixes and this series have all 
made their way through both powerpc and m68k trees, and submit it 
separately.

Thanks.

-- 
