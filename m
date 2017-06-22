Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wthnR1jBPzDr9p
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 23:12:11 +1000 (AEST)
In-Reply-To: <1497962097-9402-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: npiggin@gmail.com
Subject: Re: [1/3] powerpc/64s: Use BRANCH_TO_COMMON() for slb_miss_realmode
Message-Id: <3wthnR0dmBz9sR8@ozlabs.org>
Date: Thu, 22 Jun 2017 23:12:11 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-06-20 at 12:34:55 UTC, Michael Ellerman wrote:
> All the callers of slb_miss_realmode currently open code the #ifndef
> CONFIG_RELOCATABLE check and the branch via CTR in the RELOCATABLE case.
> We have a macro to do this, BRANCH_TO_COMMON(), so use it.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Series applied to powerpc next.

https://git.kernel.org/powerpc/c/b102063b47d59752e113c558842227

cheers
