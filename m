Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qk8fL0K24zDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 22:35:06 +1000 (AEST)
In-Reply-To: <1459116497-19991-2-git-send-email-paul.gortmaker@windriver.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>,
 <linux-kernel@vger.kernel.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [1/3] powerpc: make cell/spu_base.c explicitly non-modular
Message-Id: <3qk8fK6kfzz9t3g@ozlabs.org>
Date: Mon, 11 Apr 2016 22:35:05 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2016-27-03 at 22:08:15 UTC, Paul Gortmaker wrote:
> The Kconfig currently controlling compilation of this code is:
> 
> arch/powerpc/platforms/cell/Kconfig:config SPU_BASE
> arch/powerpc/platforms/cell/Kconfig:    bool
> 
> ...meaning that it currently is not being built as a module by anyone.
> 
> Lets remove the modular code that is essentially orphaned, so that
> when reading the driver there is no doubt it is builtin-only.
...
> 
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8038665fb54f1e54785c63be11

cheers
