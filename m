Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 804EFB6F59
 for <linuxppc-dev@ozlabs.org>; Sat, 30 Jun 2012 05:59:24 +1000 (EST)
Subject: Re: [PATCH] powerpc/fsl: Distribute interrupts on all CPUs by default
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20120413172615.136b60077051430253bb5d0a@freescale.com>
Date: Fri, 29 Jun 2012 14:59:22 -0500
Message-Id: <124C6A84-2E4D-4A46-A58D-A057D772EE25@kernel.crashing.org>
References: <20120413172615.136b60077051430253bb5d0a@freescale.com>
To: Kim Phillips <kim.phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 13, 2012, at 5:26 PM, Kim Phillips wrote:

> At least for crypto/IPSec, doing so provides users with a better
> performance experience out of the box.
> 
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
> arch/powerpc/configs/corenet32_smp_defconfig |    1 +
> arch/powerpc/configs/corenet64_smp_defconfig |    1 +
> arch/powerpc/configs/mpc85xx_smp_defconfig   |    1 +
> 3 files changed, 3 insertions(+)

applied

- k
