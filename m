Return-Path: <B11780@freescale.com>
Received: from VA3EHSOBE004.bigfish.com (va3ehsobe004.messaging.microsoft.com
	[216.32.180.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 87DE9B6F70
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 21 Jul 2011 22:13:15 +1000 (EST)
Received: from mail39-va3 (localhost.localdomain [127.0.0.1])	by
	mail39-va3-R.bigfish.com (Postfix) with ESMTP id 44FD11430204	for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jul 2011 12:13:10 +0000 (UTC)
Received: from VA3EHSMHS005.bigfish.com (unknown [10.7.14.253])	by
	mail39-va3.bigfish.com (Postfix) with ESMTP id EC08116C004C	for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jul 2011 12:13:09 +0000 (UTC)
Subject: Re: [PATCH 1/4] powerpc/85xx: fix interrupt number of
	memory-controller for P4080
MIME-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1311243889-4316-1-git-send-email-Shaohui.Xie@freescale.com>
Date: Thu, 21 Jul 2011 07:13:00 -0500
Message-ID: <65C49D37-A103-494D-AD8E-7C8FC6E3716E@freescale.com>
References: <1311243889-4316-1-git-send-email-Shaohui.Xie@freescale.com>
To: Shaohui Xie <Shaohui.Xie@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 21, 2011, at 5:24 AM, Shaohui Xie wrote:

> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> ---
> arch/powerpc/boot/dts/p4080ds.dts |    4 ++--
> 1 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/boot/dts/p4080ds.dts =
b/arch/powerpc/boot/dts/p4080ds.dts
> index 927f94d..9c37a85 100644
> --- a/arch/powerpc/boot/dts/p4080ds.dts
> +++ b/arch/powerpc/boot/dts/p4080ds.dts
> @@ -131,14 +131,14 @@
> 			compatible =3D "fsl,p4080-memory-controller";
> 			reg =3D <0x8000 0x1000>;
> 			interrupt-parent =3D <&mpic>;
> -			interrupts =3D <0x12 2>;
> +			interrupts =3D <16 2>;
> 		};
>=20
> 		memory-controller@9000 {
> 			compatible =3D "fsl,p4080-memory-controller";
> 			reg =3D <0x9000 0x1000>;
> 			interrupt-parent =3D <&mpic>;
> -			interrupts =3D <0x12 2>;
> +			interrupts =3D <16 2>;
> 		};
>=20
> 		corenet-cf@18000 {
> --=20
> 1.6.4

What code base / tree is this against?

- k=
