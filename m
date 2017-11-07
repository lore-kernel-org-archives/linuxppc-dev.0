Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yWlz40rfLzDrCb
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Nov 2017 10:30:24 +1100 (AEDT)
In-Reply-To: <20171103024146.17086-2-cyrilbur@gmail.com>
To: Cyril Bur <cyrilbur@gmail.com>, linux-mtd@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, stewart@linux.vnet.ibm.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: boris.brezillon@free-electrons.com, computersforpeace@gmail.com,
 dwmw2@infradead.org, sjitindarsingh@gmail.com
Subject: Re: [v5,
 01/10] mtd: powernv_flash: Use WARN_ON_ONCE() rather than BUG_ON()
Message-Id: <3yWlz118m4z9s7C@ozlabs.org>
Date: Wed,  8 Nov 2017 10:30:20 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-11-03 at 02:41:37 UTC, Cyril Bur wrote:
> BUG_ON() should be reserved in situations where we can not longer
> guarantee the integrity of the system. In the case where
> powernv_flash_async_op() receives an impossible op, we can still
> guarantee the integrity of the system.
> 
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/44e2aa2b16a872fa8aa4901b379313

cheers
