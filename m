Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzyBn3H1dzDrLh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 00:32:49 +1000 (AEST)
In-Reply-To: <1469415471-2476-3-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [3/3] powerpc/mm: Drop unused externs for hpte_init_beat[_v3]()
Message-Id: <3rzyBm4Zqrz9t2N@ozlabs.org>
Date: Thu, 28 Jul 2016 00:32:47 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-25-07 at 02:57:51 UTC, Michael Ellerman wrote:
> We removed the BEAT support in 2015 in commit bf4981a00636 ("powerpc:
> Remove the celleb support"). These externs are unused since then.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/1a1cee843c4a532f57083ffe8c

cheers
