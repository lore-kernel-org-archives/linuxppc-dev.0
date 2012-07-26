Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 69F9D2C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2012 04:53:35 +1000 (EST)
Subject: Re: [PATCH][v1] powerpc/85xx: Fix sram_offset parameter type
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1343314075-2127-1-git-send-email-claudiu.manoil@freescale.com>
Date: Thu, 26 Jul 2012 13:53:32 -0500
Message-Id: <03E24D9C-22D0-429D-8EEC-E390B034F1C1@kernel.crashing.org>
References: <1343314075-2127-1-git-send-email-claudiu.manoil@freescale.com>
To: Claudiu Manoil <claudiu.manoil@freescale.com>
Cc: Tang Yuantian <Yuantian.Tang@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 26, 2012, at 9:47 AM, Claudiu Manoil wrote:

> The sram_offset parameter represents a physical address
> and should be of type phys_addr_t. As part of this fix,
> the extraction of sram_params is being cleaned-up and
> fixed.
> This patch fixes now the case when the offset value of
> 0xfff00000 was being rejected by the driver (returning
> -EINVAL), although this is a valid offset value.
>=20
> Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> Signed-off-by: Claudiu Manoil <claudiu.manoil@freescale.com>
> ---
> v1: fixed copyright year format
>=20
> arch/powerpc/sysdev/fsl_85xx_cache_ctlr.h |    4 +-
> arch/powerpc/sysdev/fsl_85xx_l2ctlr.c     |   39 =
++++++++++------------------
> 2 files changed, 16 insertions(+), 27 deletions(-)

applied to merge

- k=
