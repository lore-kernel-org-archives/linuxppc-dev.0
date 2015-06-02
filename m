Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3A9971A001E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2015 19:58:55 +1000 (AEST)
In-Reply-To: <1432116013-25902-5-git-send-email-jiang.liu@linux.intel.com>
To: Jiang Liu <jiang.liu@linux.intel.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC, v1, 04/25] powerpc,
 irq: Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc
Message-Id: <20150602095854.E6D7D1412E7@ozlabs.org>
Date: Tue,  2 Jun 2015 19:58:54 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-20-05 at 09:59:52 UTC, Jiang Liu wrote:
> Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc while we
> already have a pointer to corresponding irq_desc.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> ---
>  arch/powerpc/platforms/52xx/mpc52xx_gpt.c     |    2 +-
>  arch/powerpc/platforms/cell/axon_msi.c        |    2 +-
>  arch/powerpc/platforms/embedded6xx/hlwd-pic.c |    2 +-
>  arch/powerpc/sysdev/uic.c                     |    2 +-
>  arch/powerpc/sysdev/xics/xics-common.c        |    2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)

Applied thanks.

cheers
