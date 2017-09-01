Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xkKqD4jRqzDqk0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Sep 2017 23:30:00 +1000 (AEST)
In-Reply-To: <bfb43496252dc11b95ef7e744206c2a7ad17a734.1504111164.git.arvind.yadav.cs@gmail.com>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, paulus@samba.org,
 benh@kernel.crashing.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc: 4xx: constify platform_suspend_ops
Message-Id: <3xkKqD1pfwz9t3F@ozlabs.org>
Date: Fri,  1 Sep 2017 23:29:59 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-08-30 at 16:48:20 UTC, Arvind Yadav wrote:
> platform_suspend_ops are not supposed to change at runtime.
> Functions suspend_set_ops working with const platform_suspend_ops.
> So mark the non-const structs as const.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/7def9a2418430a8af2a56023769ccd

cheers
