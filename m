Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7sS460qkzDqf4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 21:26:44 +1000 (AEST)
In-Reply-To: <20160804053703.GN775@mwanda>
To: Dan Carpenter <dan.carpenter@oracle.com>, Jeremy Kerr <jk@ozlabs.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Arnd Bergmann <arnd@arndb.de>, kernel-janitors@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: ppc/cell: missing error code in spufs_mkgang()
Message-Id: <3s7sS44Lmzz9t1Q@ozlabs.org>
Date: Tue,  9 Aug 2016 21:26:44 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-04-08 at 05:37:03 UTC, Dan Carpenter wrote:
> We should return -ENOMEM if alloc_spu_gang() fails.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/54a94fcf2f00c9deb9491d5ab2

cheers
