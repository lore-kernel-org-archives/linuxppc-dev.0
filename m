Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6456E2C010B
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2012 01:58:34 +1000 (EST)
Subject: Re: [PATCH 1/2] powerpc/fsl: update defconfigs
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20120822134324.c504462a553c7a861f3e9865@freescale.com>
Date: Thu, 23 Aug 2012 10:58:17 -0500
Message-Id: <E22F3582-83E4-40E9-9B7B-E671C8166C41@kernel.crashing.org>
References: <20120821172303.53d5698006b32063dca99300@freescale.com>
 <94E5411D-0FC7-46AF-BDE4-FC87416DF805@kernel.crashing.org>
 <20120822134324.c504462a553c7a861f3e9865@freescale.com>
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


On Aug 22, 2012, at 1:43 PM, Kim Phillips wrote:

> run make savedefconfig on fsl defconfigs.
>=20
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
> arch/powerpc/configs/85xx/p1023rds_defconfig | 30 =
++++++++-------------------
> arch/powerpc/configs/corenet32_smp_defconfig | 28 =
+++++++------------------
> arch/powerpc/configs/mpc83xx_defconfig       | 17 ++++-----------
> arch/powerpc/configs/mpc85xx_defconfig       | 31 =
+++++++---------------------
> arch/powerpc/configs/mpc85xx_smp_defconfig   | 31 =
+++++++---------------------
> 5 files changed, 35 insertions(+), 102 deletions(-)

applied to merge

- k=
