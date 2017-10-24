Return-Path: <qiang.zhao@nxp.com>
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0062.outbound.protection.outlook.com [104.47.0.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yLbpq5GwyzDqZ3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 12:51:29 +1100 (AEDT)
From: Qiang Zhao <qiang.zhao@nxp.com>
To: Qiang Zhao <qiang.zhao@nxp.com>, "tglx@linutronix.de" <tglx@linutronix.de>
CC: "oss@buserror.net" <oss@buserror.net>, Xiaobo Xie <xiaobo.xie@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH v10 0/4] this patchset is to remove PPCisms for QEIC
Date: Tue, 24 Oct 2017 01:51:22 +0000
Message-ID: <AM3PR04MB1185BD257F6BDE880B2C92B391470@AM3PR04MB1185.eurprd04.prod.outlook.com>
References: <1502075236-24078-1-git-send-email-qiang.zhao@nxp.com>
In-Reply-To: <1502075236-24078-1-git-send-email-qiang.zhao@nxp.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

Could anybody review this patchset and take action on them? Thank you!

Best Regards
Qiang Zhao

> -----Original Message-----
> From: Zhao Qiang [mailto:qiang.zhao@nxp.com]
> Sent: Monday, August 07, 2017 11:07 AM
> To: tglx@linutronix.de
> Cc: oss@buserror.net; Xiaobo Xie <xiaobo.xie@nxp.com>; linux-
> kernel@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; Qiang Zhao
> <qiang.zhao@nxp.com>
> Subject: [PATCH v10 0/4] this patchset is to remove PPCisms for QEIC
>=20
> QEIC is supported more than just powerpc boards, so remove PPCisms.
>=20
> changelog:
> 	Changes for v8:
> 	- use IRQCHIP_DECLARE() instead of subsys_initcall in qeic driver
> 	- remove include/soc/fsl/qe/qe_ic.h
> 	Changes for v9:
> 	- rebase
> 	- fix the compile issue when apply the second patch, in fact, there was
> no compile issue
> 	  when apply all the patches of this patchset
> 	Changes for v10:
> 	- simplify codes, remove duplicated codes
>=20
> Zhao Qiang (4):
>   irqchip/qeic: move qeic driver from drivers/soc/fsl/qe
> 	Changes for v2:
> 		- modify the subject and commit msg
> 	Changes for v3:
> 		- merge .h file to .c, rename it with irq-qeic.c
> 	Changes for v4:
> 		- modify comments
> 	Changes for v5:
> 		- disable rename detection
> 	Changes for v6:
> 		- rebase
> 	Changes for v7:
> 		- na
>=20
>   irqchip/qeic: merge qeic init code from platforms to a common function
> 	Changes for v2:
> 		- modify subject and commit msg
> 		- add check for qeic by type
> 	Changes for v3:
> 		- na
> 	Changes for v4:
> 		- na
> 	Changes for v5:
> 		- na
> 	Changes for v6:
> 		- rebase
> 	Changes for v7:
> 		- na
> 	Changes for v8:
> 		- use IRQCHIP_DECLARE() instead of subsys_initcall
>=20
>   irqchip/qeic: merge qeic_of_init into qe_ic_init
> 	Changes for v2:
> 		- modify subject and commit msg
> 		- return 0 and add put node when return in qe_ic_init
> 	Changes for v3:
> 		- na
> 	Changes for v4:
> 		- na
> 	Changes for v5:
> 		- na
> 	Changes for v6:
> 		- rebase
> 	Changes for v7:
> 		- na
>=20
>   irqchip/qeic: remove PPCisms for QEIC
> 	Changes for v6:
> 		- new added
> 	Changes for v7:
> 		- fix warning
> 	Changes for v8:
> 		- remove include/soc/fsl/qe/qe_ic.h
>=20
> Zhao Qiang (4):
>   irqchip/qeic: move qeic driver from drivers/soc/fsl/qe
>   irqchip/qeic: merge qeic init code from platforms to a common function
>   irqchip/qeic: merge qeic_of_init into qe_ic_init
>   irqchip/qeic: remove PPCisms for QEIC
>=20
>  MAINTAINERS                                        |   6 +
>  arch/powerpc/platforms/83xx/km83xx.c               |   1 -
>  arch/powerpc/platforms/83xx/misc.c                 |  16 -
>  arch/powerpc/platforms/83xx/mpc832x_mds.c          |   1 -
>  arch/powerpc/platforms/83xx/mpc832x_rdb.c          |   1 -
>  arch/powerpc/platforms/83xx/mpc836x_mds.c          |   1 -
>  arch/powerpc/platforms/83xx/mpc836x_rdk.c          |   1 -
>  arch/powerpc/platforms/85xx/corenet_generic.c      |  10 -
>  arch/powerpc/platforms/85xx/mpc85xx_mds.c          |  15 -
>  arch/powerpc/platforms/85xx/mpc85xx_rdb.c          |  17 -
>  arch/powerpc/platforms/85xx/twr_p102x.c            |  15 -
>  drivers/irqchip/Makefile                           |   1 +
>  drivers/{soc/fsl/qe/qe_ic.c =3D> irqchip/irq-qeic.c} | 358 ++++++++++++-=
--------
>  drivers/soc/fsl/qe/Makefile                        |   2 +-
>  drivers/soc/fsl/qe/qe_ic.h                         | 103 ------
>  include/soc/fsl/qe/qe_ic.h                         | 139 --------
>  16 files changed, 218 insertions(+), 469 deletions(-)  rename
> drivers/{soc/fsl/qe/qe_ic.c =3D> irqchip/irq-qeic.c} (58%)  delete mode 1=
00644
> drivers/soc/fsl/qe/qe_ic.h  delete mode 100644 include/soc/fsl/qe/qe_ic.h
>=20
> --
> 2.1.0.27.g96db324
