Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 13B77B7D0E
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Apr 2010 14:13:42 +1000 (EST)
Subject: Re: [PATCH 1/2] powerpc: 83xx: add RTC drivers in 83xx defconfig
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20100405111351.0804d3bb.kim.phillips@freescale.com>
Date: Mon, 19 Apr 2010 23:13:36 -0500
Message-Id: <2A4AA2EA-9132-4525-9FE1-2AAB9437E1D3@kernel.crashing.org>
References: <20100405111351.0804d3bb.kim.phillips@freescale.com>
To: Kim Phillips <Kim.Phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 5, 2010, at 11:13 AM, Kim Phillips wrote:

> 83xx boards typically have the DS1307 or DS1374:
>=20
> git grep RTC_DRV arch/powerpc/configs/*83* | grep "=3Dy"
> arch/powerpc/configs/83xx/asp8347_defconfig:CONFIG_RTC_DRV_DS1374=3Dy
> =
arch/powerpc/configs/83xx/mpc8313_rdb_defconfig:CONFIG_RTC_DRV_DS1307=3Dy
> =
arch/powerpc/configs/83xx/mpc8315_rdb_defconfig:CONFIG_RTC_DRV_DS1307=3Dy
> =
arch/powerpc/configs/83xx/mpc832x_mds_defconfig:CONFIG_RTC_DRV_DS1374=3Dy
> =
arch/powerpc/configs/83xx/mpc834x_itx_defconfig:CONFIG_RTC_DRV_DS1307=3Dy
> =
arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig:CONFIG_RTC_DRV_DS1307=3D=
y
> =
arch/powerpc/configs/83xx/mpc834x_mds_defconfig:CONFIG_RTC_DRV_DS1374=3Dy
> =
arch/powerpc/configs/83xx/mpc836x_mds_defconfig:CONFIG_RTC_DRV_DS1374=3Dy
>=20
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
> arch/powerpc/configs/mpc83xx_defconfig |   62 =
++++++++++++++++++++++++++++++--
> 1 files changed, 59 insertions(+), 3 deletions(-)

applied to merge.

- k=
