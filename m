Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xbZXq3zdDzDqTt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 23:39:07 +1000 (AEST)
In-Reply-To: <7ce0e2734a7e95d3341c7424d124ddfd4bc82034.1497850925.git.arvind.yadav.cs@gmail.com>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, benh@kernel.crashing.org,
 mingo@kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v2] macintosh: rack-meter: make of_device_ids const.
Message-Id: <3xbZXq2CBfz9sR8@ozlabs.org>
Date: Mon, 21 Aug 2017 23:39:07 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-06-19 at 05:44:25 UTC, Arvind Yadav wrote:
> of_device_ids are not supposed to change at runtime. All functions
> working with of_device_ids provided by <linux/of.h> work with const
> of_device_ids. So mark the non-const structs as const.
> 
> File size before:
>    text	   data	    bss	    dec	    hex	filename
>     407	    576	      0	    983	    3d7	drivers/macintosh/rack-meter.o
> 
> File size after constify rackmeter_match.
>    text	   data	    bss	    dec	    hex	filename
>     807	    176	      0	    983	    3d7	drivers/macintosh/rack-meter.o
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/516fa8d0e19d854253460ea7692551

cheers
