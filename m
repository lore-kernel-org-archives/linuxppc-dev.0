Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E572DB7D11
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 20 Apr 2010 14:15:30 +1000 (EST)
Subject: Re: [PATCH 2/2] powerpc: mpc8xxx defconfigs: turn off SYSFS_DEPRECATED
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20100415185918.3066f873.kim.phillips@freescale.com>
Date: Mon, 19 Apr 2010 23:15:22 -0500
Message-Id: <D8A0D2B0-E86D-4796-A1E2-CC075B523969@kernel.crashing.org>
References: <20100415185918.3066f873.kim.phillips@freescale.com>
To: Kim Phillips <Kim.Phillips@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 15, 2010, at 6:59 PM, Kim Phillips wrote:

> a recent fc11 udev update on an 83xx board made root console login
> disappear:
>=20
>  Updating       : udev-141-8.fc11.ppc                                  =
  32/83
> udev: starting version 141
> udev: deprecated sysfs layout; update the kernel or disable =
CONFIG_SYSFS_DEPRECATED; some udev features will not work correctly
>=20
> and sure enough, turning off SYSFS_DEPRECATED brings the login prompt
> back.
>=20
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
> arch/powerpc/configs/83xx/asp8347_defconfig       |    3 +--
> arch/powerpc/configs/83xx/mpc8313_rdb_defconfig   |    3 +--
> arch/powerpc/configs/83xx/mpc8315_rdb_defconfig   |    3 +--
> arch/powerpc/configs/83xx/mpc832x_mds_defconfig   |    3 +--
> arch/powerpc/configs/83xx/mpc832x_rdb_defconfig   |    3 +--
> arch/powerpc/configs/83xx/mpc834x_itx_defconfig   |    3 +--
> arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig |    3 +--
> arch/powerpc/configs/83xx/mpc834x_mds_defconfig   |    3 +--
> arch/powerpc/configs/83xx/mpc836x_mds_defconfig   |    3 +--
> arch/powerpc/configs/83xx/mpc836x_rdk_defconfig   |    3 +--
> arch/powerpc/configs/83xx/mpc837x_mds_defconfig   |    3 +--
> arch/powerpc/configs/83xx/mpc837x_rdb_defconfig   |    3 +--
> arch/powerpc/configs/83xx/sbc834x_defconfig       |    3 +--
> arch/powerpc/configs/85xx/ksi8560_defconfig       |    3 +--
> arch/powerpc/configs/85xx/mpc8540_ads_defconfig   |    3 +--
> arch/powerpc/configs/85xx/mpc8560_ads_defconfig   |    3 +--
> arch/powerpc/configs/85xx/mpc85xx_cds_defconfig   |    3 +--
> arch/powerpc/configs/85xx/sbc8548_defconfig       |    3 +--
> arch/powerpc/configs/85xx/sbc8560_defconfig       |    3 +--
> arch/powerpc/configs/85xx/socrates_defconfig      |    3 +--
> arch/powerpc/configs/85xx/stx_gp3_defconfig       |    3 +--
> arch/powerpc/configs/85xx/tqm8540_defconfig       |    3 +--
> arch/powerpc/configs/85xx/tqm8541_defconfig       |    3 +--
> arch/powerpc/configs/85xx/tqm8548_defconfig       |    3 +--
> arch/powerpc/configs/85xx/tqm8555_defconfig       |    3 +--
> arch/powerpc/configs/85xx/tqm8560_defconfig       |    3 +--
> arch/powerpc/configs/85xx/xes_mpc85xx_defconfig   |    3 +--
> arch/powerpc/configs/mpc8272_ads_defconfig        |    3 +--
> arch/powerpc/configs/mpc83xx_defconfig            |    3 +--
> arch/powerpc/configs/mpc85xx_defconfig            |    3 +--
> arch/powerpc/configs/mpc85xx_smp_defconfig        |    3 +--
> arch/powerpc/configs/mpc866_ads_defconfig         |    3 +--
> arch/powerpc/configs/mpc86xx_defconfig            |    3 +--
> arch/powerpc/configs/mpc885_ads_defconfig         |    3 +--
> 34 files changed, 34 insertions(+), 68 deletions(-)


applied to merge.

- k=
