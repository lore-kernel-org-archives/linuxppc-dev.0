Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A0A6C2C008E
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Aug 2012 13:51:50 +1000 (EST)
Subject: Re: [PATCH] powerpc/fsl: fix "Failed to mount /dev: No such device"
 errors
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20120821172303.53d5698006b32063dca99300@freescale.com>
Date: Tue, 21 Aug 2012 22:51:42 -0500
Message-Id: <94E5411D-0FC7-46AF-BDE4-FC87416DF805@kernel.crashing.org>
References: <20120821172303.53d5698006b32063dca99300@freescale.com>
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


On Aug 21, 2012, at 5:23 PM, Kim Phillips wrote:

> Yocto (Built by Poky 7.0) 1.2 root filesystems fail to boot,
> at least over nfs, with:
>=20
> Failed to mount /dev: No such device
>=20
> Configuring DEVTMPFS fixes it.
>=20
> Note: all non-DEVTMPFS changes are due to the side effects of
> running make savedefconfig.
>=20
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
> if the savedefconfig effects are undesired, I can re-post
> a two-patch series, the first the result of only running
> savedefconfig, the second the addition of DEVTMPFS.
>=20
> based on Kumar's powerpc.git next branch (commit 1ee9545)
>=20
> arch/powerpc/configs/85xx/p1023rds_defconfig | 31 =
+++++++++------------------
> arch/powerpc/configs/corenet32_smp_defconfig | 29 =
++++++++-----------------
> arch/powerpc/configs/corenet64_smp_defconfig |  1 +
> arch/powerpc/configs/mpc83xx_defconfig       | 18 +++++-----------
> arch/powerpc/configs/mpc85xx_defconfig       | 32 =
+++++++---------------------
> arch/powerpc/configs/mpc85xx_smp_defconfig   | 32 =
+++++++---------------------
> 6 files changed, 41 insertions(+), 102 deletions(-)

Do split this into 2 patches.. Also do it against 'merge' and not 'next' =
as this fix should go into v3.6.

- k=
