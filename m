Return-Path: <B38951@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E85A22C020B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2012 20:29:03 +1000 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Jia Hongtao-B38951 <B38951@freescale.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "galak@kernel.crashing.org"
 <galak@kernel.crashing.org>
Subject: RE: [PATCH] powerpc/sgmii: Add phy nodes in SGMII mode
Date: Thu, 12 Jul 2012 10:28:55 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01A228F9@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1342085776-13289-1-git-send-email-B38951@freescale.com>
In-Reply-To: <1342085776-13289-1-git-send-email-B38951@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Note that this patch works with uboot update.
Please refer to:
http://patchwork.ozlabs.org/patch/170627/

-Hongtao.

> -----Original Message-----
> From: Jia Hongtao-B38951
> Sent: Thursday, July 12, 2012 5:36 PM
> To: linuxppc-dev@lists.ozlabs.org; galak@kernel.crashing.org
> Cc: Li Yang-R58472; Jia Hongtao-B38951
> Subject: [PATCH] powerpc/sgmii: Add phy nodes in SGMII mode
>=20
> In SGMII riser card different PHY chip are used with different external
> IRQ from eTSEC. To support PHY link state auto detect in SGMII mode we
> should add another group of PHY nodes for SGMII mode.
>=20
> For MPC8572DS IRQ6 is used for PHY0~PHY1, IRQ7 is used for PHY2~PHY3.
> For MPC8544DS and MPC8536DS IRQ6 is used for PHY0~PHY1.
> For P2020DS IRQ5 is used for PHY1~PHY2.
>=20
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Jia Hongtao <B38951@freescale.com>
> ---
>  arch/powerpc/boot/dts/mpc8536ds.dtsi |    8 ++++++++
>  arch/powerpc/boot/dts/mpc8544ds.dtsi |    9 +++++++++
>  arch/powerpc/boot/dts/mpc8572ds.dtsi |   17 +++++++++++++++++
>  arch/powerpc/boot/dts/p2020ds.dtsi   |   10 ++++++++++
>  4 files changed, 44 insertions(+), 0 deletions(-)
>=20
