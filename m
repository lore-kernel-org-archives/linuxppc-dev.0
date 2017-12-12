Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ywyXZ0CggzDqmD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Dec 2017 22:39:26 +1100 (AEDT)
In-Reply-To: <20171113120655.30725-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: powerpc/32: Add .data.rel* sections explicitly
Message-Id: <3ywyXY3Tfmz9t3t@ozlabs.org>
Date: Tue, 12 Dec 2017 22:39:25 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-11-13 at 12:06:55 UTC, Nicholas Piggin wrote:
> Match powerpc/64 and include .data.rel* input sections in the .data output
> section explicitly.
> 
> This solves the warning:
> 
> powerpc-linux-gnu-ld: warning: orphan section `.data.rel.ro' from `arch/powerpc/kernel/head_44x.o' being placed in section `.data.rel.ro'.
> 
> Link: https://lists.01.org/pipermail/kbuild-all/2017-November/040010.html
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a10726075dec4ceb050c2f775e5436

cheers
