Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CC1892C00AF
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2012 01:58:26 +1000 (EST)
Subject: Re: [PATCH 2/2 v2] powerpc/fsl: fix "Failed to mount /dev: No such
 device" errors
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20120822134330.288990f2699569868923c23c@freescale.com>
Date: Thu, 23 Aug 2012 10:58:15 -0500
Message-Id: <A9EC53D6-102A-4197-9236-A24459CC118E@kernel.crashing.org>
References: <20120821172303.53d5698006b32063dca99300@freescale.com>
 <94E5411D-0FC7-46AF-BDE4-FC87416DF805@kernel.crashing.org>
 <20120822134330.288990f2699569868923c23c@freescale.com>
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

> Yocto (Built by Poky 7.0) 1.2 root filesystems fail to boot,
> at least over nfs, with:
> 
> Failed to mount /dev: No such device
> 
> Configuring DEVTMPFS fixes it.
> 
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
> v2: separated savedefconfig updates, rebased on merge branch
> 
> arch/powerpc/configs/85xx/p1023rds_defconfig | 1 +
> arch/powerpc/configs/corenet32_smp_defconfig | 1 +
> arch/powerpc/configs/corenet64_smp_defconfig | 1 +
> arch/powerpc/configs/mpc83xx_defconfig       | 1 +
> arch/powerpc/configs/mpc85xx_defconfig       | 1 +
> arch/powerpc/configs/mpc85xx_smp_defconfig   | 1 +
> 6 files changed, 6 insertions(+)

applied to merge

- k
