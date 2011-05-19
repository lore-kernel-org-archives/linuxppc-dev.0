Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D7AA2100E4C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 16:03:47 +1000 (EST)
Subject: Re: [PATCH 2/2] powerpc/fsl: enable verbose bug output
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20110510180206.GB18443@schlenkerla.am.freescale.net>
Date: Thu, 19 May 2011 01:02:06 -0500
Message-Id: <77122B2B-841C-4D8B-8037-2D822BD6304B@kernel.crashing.org>
References: <20110510180206.GB18443@schlenkerla.am.freescale.net>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 10, 2011, at 1:02 PM, Scott Wood wrote:

> This debug option has no overhead other than a slight increase in
> kernel size, and makes bug reports more useful.  While some end users
> may prefer to save the space, as a default on a kernel config aimed
> primarily at development on reference boards, it should be enabled.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> arch/powerpc/configs/83xx/mpc8313_rdb_defconfig  |    1 -
> arch/powerpc/configs/83xx/mpc8315_rdb_defconfig  |    1 -
> arch/powerpc/configs/85xx/mpc8540_ads_defconfig  |    1 -
> arch/powerpc/configs/85xx/mpc8560_ads_defconfig  |    1 -
> arch/powerpc/configs/85xx/mpc85xx_cds_defconfig  |    1 -
> arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig |    1 -
> arch/powerpc/configs/e55xx_smp_defconfig         |    1 -
> arch/powerpc/configs/mpc85xx_defconfig           |    1 -
> arch/powerpc/configs/mpc85xx_smp_defconfig       |    1 -
> arch/powerpc/configs/mpc86xx_defconfig           |    1 -
> 10 files changed, 0 insertions(+), 10 deletions(-)

applied to next

- k
