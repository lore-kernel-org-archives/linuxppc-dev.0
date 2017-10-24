Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yLmBc1HxRzDqmQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 19:09:12 +1100 (AEDT)
In-Reply-To: <1508264418-13448-1-git-send-email-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Breno Leitao <leitao@debian.org>
Subject: Re: powerpc/xmon: check before calling xive functions
Message-Id: <3yLmBc0g0lz9sDB@ozlabs.org>
Date: Tue, 24 Oct 2017 19:09:11 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-10-17 at 18:20:18 UTC, Breno Leitao wrote:
> Currently xmon could call XIVE functions from OPAL even if the XIVE is
> disabled or does not exist in the system, as in POWER8 machines.  This
> causes the following exception:
> 
>  1:mon> dx
>  cpu 0x1: Vector: 700 (Program Check) at [c000000423c93450]
>      pc: c00000000009cfa4: opal_xive_dump+0x50/0x68
>      lr: c0000000000997b8: opal_return+0x0/0x50
> 
> This patch simply checks if XIVE is enabled before calling XIVE
> functions.
> 
> Suggested-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/402e172a2ce76210f2fe921cf419d1

cheers
