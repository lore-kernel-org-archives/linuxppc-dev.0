Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjgL04WR2zDqTc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 21:35:52 +1000 (AEST)
In-Reply-To: <20170413072045.17956-1-bsingharora@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/configs: Enable THP and 64K for ppc64(le)_defconfig
Message-Id: <3xjgL03vHmz9t2R@ozlabs.org>
Date: Thu, 31 Aug 2017 21:35:52 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-04-13 at 07:20:45 UTC, Balbir Singh wrote:
> Enable 64K page size and THP. I use ppc64le_defconfig when I need
> a single config across guest and host, but having 4K page size
> as default is not what I expect. I could move these over to
> server.config and merge if ppc64_defconfig is meant for systems
> that use 4k pages by default.
> 
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/5b593949f8ff2b505e68bf044ea458

cheers
