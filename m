Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tN60r5l2JzDvmq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 11:34:20 +1100 (AEDT)
In-Reply-To: <1479430638-4186-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/lib: Fix randconfig build failure in sstep.c
Message-Id: <3tN60r3HFNz9t2G@ozlabs.org>
Date: Tue, 22 Nov 2016 11:34:20 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-11-18 at 00:57:18 UTC, Michael Ellerman wrote:
> Under some configs we need to explicitly include cpu_has_feature.h,
> otherwise we fail with:
> 
>   arch/powerpc/lib/sstep.c:1992:7: error: implicit declaration of function 'cpu_has_feature'
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/5e9d0e3d9ea6f771fa9fc9dbb65b54

cheers
