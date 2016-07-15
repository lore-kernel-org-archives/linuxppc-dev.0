Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrTvR5dd1zDqyc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 20:53:39 +1000 (AEST)
In-Reply-To: <1468284892-27765-4-git-send-email-dja@axtens.net>
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: arnd@arndb.de, Daniel Axtens <dja@axtens.net>
Subject: Re: [v2,4/5] powerpc/sparse: Pass endianness to sparse
Message-Id: <3rrTvR2mk2z9s6r@ozlabs.org>
Date: Fri, 15 Jul 2016 20:53:39 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-12-07 at 00:54:51 UTC, Daniel Axtens wrote:
> Explicitly give sparse an endianness in the Makefile, so that it
> doesn't get confused.
> 
> Normally we have #ifdef one and #else the other, so it doesn't usually
> matter, but we have been bitten by it before, and indeed this patch
> fixes a number of sparse errors.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/62c2c5cf387beb4bbf45045c30

cheers
