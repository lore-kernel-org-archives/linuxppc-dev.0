Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40skqk3pXHzF1lS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 21:41:54 +1000 (AEST)
In-Reply-To: <20180523114837.6980-2-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: malat@debian.org
Subject: Re: [2/2] powerpc/xmon: Realign paca dump fields
Message-Id: <40skqj5p5Xz9s1d@ozlabs.org>
Date: Fri, 25 May 2018 21:41:52 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-05-23 at 11:48:37 UTC, Michael Ellerman wrote:
> We've added some fields with longer names since we originally wrote
> this, so the fields are no longer lined up. Adjust the widths to make
> it all look nice again, eg:
> 
>   0:mon> dp
>   paca for cpu 0x0 @ c000000001fa0000:
>    possible                  = yes
>    ...
>    slb_shadow            [0] = 0xc000000008000000 0x400ea1b217000500
>    slb_shadow            [1] = 0xd000000008000001 0x400d43642f000510
>    ...
>    rfi_flush_fallback_area   = c0000000fff80000   (0xcc8)
>    ...
>    accounting.starttime_user = 0x51582f07         (0xae8)
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/9ce53e27265e7bab728774fac785f6

cheers
