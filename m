Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sYNvJ4cLxzDsTV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 22:16:28 +1000 (AEST)
In-Reply-To: <1473139963-7496-1-git-send-email-dja@axtens.net>
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Daniel Axtens <dja@axtens.net>
Subject: Re: [v2,1/5] powerpc/cell: drop unused iic_get_irq_host()
Message-Id: <3sYNvJ3kRSz9t0J@ozlabs.org>
Date: Tue, 13 Sep 2016 22:16:28 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-06-09 at 05:32:39 UTC, Daniel Axtens wrote:
> Sparse checking revealed that it is no longer used.
> There is an EXPORT_SYMBOL_GPL, but there's no header that
> provides a prototype, so nothing should be using it anyway.
> 
> Remove it.
> 
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/bc42f1d9f5b31060a3c6b83983

cheers
