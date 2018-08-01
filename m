Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41gMDG4LnTzF10S
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2018 15:23:58 +1000 (AEST)
In-Reply-To: <720e9899186bed184fb9b5cce070e2dc519f9665.1530519301.git.fthain@telegraphics.com.au>
To: Finn Thain <fthain@telegraphics.com.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Michael Schmitz <schmitzmic@gmail.com>, linux-m68k@lists.linux-m68k.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v4,01/11] macintosh/via-pmu: Fix section mismatch warning
Message-Id: <41gMDG3RdFz9s3q@ozlabs.org>
Date: Wed,  1 Aug 2018 15:23:58 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-07-02 at 08:21:18 UTC, Finn Thain wrote:
> The pmu_init() function has the __init qualifier, but the ops struct
> that holds a pointer to it does not. This causes a build warning.
> The driver works fine because the pointer is only dereferenced early.
> 
> The function is so small that there's negligible benefit from using
> the __init qualifier. Remove it to fix the warning, consistent with
> the other ADB drivers.
> 
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/73f4447d43484224d7abfba0d9468d

cheers
