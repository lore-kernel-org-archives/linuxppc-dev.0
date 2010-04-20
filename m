Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CE149B7E07
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Apr 2010 14:13:47 +1000 (EST)
Subject: Re: [PATCH 2/2] powerpc: 83xx: enable EPOLL syscall in defconfig
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20100405111404.8ae57791.kim.phillips@freescale.com>
Date: Mon, 19 Apr 2010 23:13:42 -0500
Message-Id: <CAF2FD0D-0139-424E-9CE5-249E2A569A33@kernel.crashing.org>
References: <20100405111404.8ae57791.kim.phillips@freescale.com>
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


On Apr 5, 2010, at 11:14 AM, Kim Phillips wrote:

> 83xx users looking to run apache will experience this error:
>=20
> /var/log/apache2/error.log:
> [emerg] (38)Function not implemented: Couldn't create pollset in =
child; check system or user limits
>=20
> enabling CONFIG_EPOLL in kernel config fixes this so apache can run.
>=20
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
> arch/powerpc/configs/83xx/asp8347_defconfig       |    2 +-
> arch/powerpc/configs/83xx/mpc8313_rdb_defconfig   |    2 +-
> arch/powerpc/configs/83xx/mpc8315_rdb_defconfig   |    2 +-
> arch/powerpc/configs/83xx/mpc832x_mds_defconfig   |    2 +-
> arch/powerpc/configs/83xx/mpc832x_rdb_defconfig   |    2 +-
> arch/powerpc/configs/83xx/mpc834x_itx_defconfig   |    2 +-
> arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig |    2 +-
> arch/powerpc/configs/83xx/mpc834x_mds_defconfig   |    2 +-
> arch/powerpc/configs/83xx/mpc836x_mds_defconfig   |    2 +-
> arch/powerpc/configs/83xx/mpc836x_rdk_defconfig   |    2 +-
> arch/powerpc/configs/83xx/mpc837x_mds_defconfig   |    2 +-
> arch/powerpc/configs/83xx/mpc837x_rdb_defconfig   |    2 +-
> arch/powerpc/configs/83xx/sbc834x_defconfig       |    2 +-
> arch/powerpc/configs/mpc83xx_defconfig            |    2 +-
> 14 files changed, 14 insertions(+), 14 deletions(-)


applied to merge.

- k=
