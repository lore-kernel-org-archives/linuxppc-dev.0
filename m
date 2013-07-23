Return-Path: <B43644@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0D9512C007C
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Jul 2013 17:13:59 +1000 (EST)
Received: from mail219-tx2 (localhost [127.0.0.1])	by
 mail219-tx2-R.bigfish.com (Postfix) with ESMTP id 530B87401CD	for
 <linuxppc-dev@ozlabs.org>; Tue, 23 Jul 2013 07:13:56 +0000 (UTC)
Received: from TX2EHSMHS007.bigfish.com (unknown [10.9.14.227])	by
 mail219-tx2.bigfish.com (Postfix) with ESMTP id 7A70E3A0048	for
 <linuxppc-dev@ozlabs.org>; Tue, 23 Jul 2013 07:13:54 +0000 (UTC)
From: Liu Po-B43644 <B43644@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [4/4] powerpc/85xx: Update mpc85xx_defconfig for C293PCIE
Date: Tue, 23 Jul 2013 07:13:52 +0000
Message-ID: <D473A0D087F4EA47A30C37E4637E25E609DAC24C@039-SN2MPN1-021.039d.mgd.msft.net>
References: <1366854857-22791-4-git-send-email-Po.Liu@freescale.com>
 <20130722230026.GA26621@home.buserror.net>
In-Reply-To: <20130722230026.GA26621@home.buserror.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Hu Mingkai-B21284 <B21284@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>





-----Original Message-----
From: Wood Scott-B07421=20
Sent: Tuesday, July 23, 2013 7:00 AM
To: Liu Po-B43644
Cc: linuxppc-dev@ozlabs.org; Hu Mingkai-B21284
Subject: Re: [4/4] powerpc/85xx: Update mpc85xx_defconfig for C293PCIE

On Thu, Apr 25, 2013 at 09:54:17AM +0800, Po Liu wrote:
> From: Mingkai Hu <Mingkai.Hu@freescale.com>
>=20
> Signed-off-by: Mingkai Hu <Mingkai.Hu@freescale.com>
>=20
> ---
> Base on git://git.am.freescale.net/gitolite/mirrors/linux-2.6.git
>  arch/powerpc/configs/mpc85xx_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/powerpc/configs/mpc85xx_defconfig=20
> b/arch/powerpc/configs/mpc85xx_defconfig
> index cf815e8..ddc33a2 100644
> --- a/arch/powerpc/configs/mpc85xx_defconfig
> +++ b/arch/powerpc/configs/mpc85xx_defconfig
> @@ -28,6 +28,7 @@ CONFIG_MPC85xx_MDS=3Dy  CONFIG_MPC8536_DS=3Dy =20
> CONFIG_MPC85xx_DS=3Dy  CONFIG_MPC85xx_RDB=3Dy
> +CONFIG_C293_PCIE=3Dy
>  CONFIG_P1010_RDB=3Dy
>  CONFIG_P1022_DS=3Dy
>  CONFIG_P1022_RDK=3Dy

Also, why only mpc85xx_defconfig and mpc85xx_smp_defconfig?  Just because t=
his board isn't SMP doesn't mean it can't be supported by an SMP kernel.
Action: I will add configure to  mpc85xx_smp_defconfig. And merge it to Add=
-C293PCIE-board-support.patch.
-Scott
