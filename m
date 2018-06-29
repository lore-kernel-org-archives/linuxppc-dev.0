Return-Path: <diana.craciun@nxp.com>
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr10043.outbound.protection.outlook.com [40.107.1.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41HK0c5JF6zF1Nf
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jun 2018 00:34:22 +1000 (AEST)
From: Diana Madalina Craciun <diana.craciun@nxp.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
CC: "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "oss@buserror.net"
 <oss@buserror.net>, Leo Li <leoyang.li@nxp.com>, Bharat Bhushan
 <bharat.bhushan@nxp.com>
Subject: Re: [PATCH v2 0/3] powerpc/fsl: Speculation barrier for NXP PowerPC
 Book3E
Date: Fri, 29 Jun 2018 14:34:15 +0000
Message-ID: <VI1PR0401MB24635C491443351EB2A2326CFF4E0@VI1PR0401MB2463.eurprd04.prod.outlook.com>
References: <1528721608-15443-1-git-send-email-diana.craciun@nxp.com>
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

Hi,=0A=
=0A=
Should I rebase the series on top of the latest kernel?=0A=
=0A=
Diana=0A=
=0A=
On 6/11/2018 3:53 PM, Diana Craciun wrote:=0A=
> Implement barrier_nospec for NXP PowerPC Book3E processors. =0A=
>=0A=
> Diana Craciun (3):=0A=
>   Disable the speculation barrier from the command line=0A=
>   Add barrier_nospec implementation for NXP PowerPC Book3E=0A=
>   Implement cpu_show_spectre_v1/v2 for NXP PowerPC Book3E=0A=
>=0A=
>  arch/powerpc/Kconfig               |  2 +-=0A=
>  arch/powerpc/include/asm/barrier.h | 10 +++++++++=0A=
>  arch/powerpc/include/asm/setup.h   |  2 +-=0A=
>  arch/powerpc/kernel/Makefile       |  2 +-=0A=
>  arch/powerpc/kernel/module.c       |  5 +++--=0A=
>  arch/powerpc/kernel/security.c     | 42 ++++++++++++++++++++++++++++++++=
+++++-=0A=
>  arch/powerpc/kernel/setup_32.c     |  5 +++++=0A=
>  arch/powerpc/kernel/setup_64.c     |  6 ++++++=0A=
>  arch/powerpc/kernel/vmlinux.lds.S  |  4 +++-=0A=
>  arch/powerpc/lib/feature-fixups.c  | 35 ++++++++++++++++++++++++++++++-=
=0A=
>  10 files changed, 105 insertions(+), 8 deletions(-)=0A=
>=0A=
> --=0A=
> History:=0A=
>=0A=
> v1 --> v2=0A=
> - added implementation for cpu_show_spectre_x functions=0A=
> - the mitigation is no longer enabled through device tree options=0A=
> 2.5.5=0A=
>=0A=
>=0A=
=0A=
