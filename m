Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjgLh0Gf0zDqTs
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 21:36:28 +1000 (AEST)
In-Reply-To: <20170829072236.16948-1-bsingharora@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/xmon: convert 0.16x to 0.16lx
Message-Id: <3xjgLg5Z9Rz9t3f@ozlabs.org>
Date: Thu, 31 Aug 2017 21:36:26 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-08-29 at 07:22:36 UTC, Balbir Singh wrote:
> Otherwise we lose the top 8 nibbles and effectively print only
> the last 32 bits.
> 
> Fixes: e0ddf7a ("powerpc/xmon: Dump ISA 2.07 SPRs")
> Fixes: 1846193 ("powerpc/xmon: Dump ISA 2.06 SPRs")
> 
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c47a94031e81bd497704a535d60d02

cheers
