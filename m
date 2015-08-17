Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0101.outbound.protection.outlook.com [157.56.110.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E709A1A1D73
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 15:50:42 +1000 (AEST)
From: Wang Dongsheng <Dongsheng.Wang@freescale.com>
To: Wang Dongsheng <Dongsheng.Wang@freescale.com>, Scott Wood
 <scottwood@freescale.com>
CC: Priyanka Jain <Priyanka.Jain@freescale.com>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH v2 1/2] powerpc/85xx: Add binding for SCFG
Date: Mon, 17 Aug 2015 05:50:35 +0000
Message-ID: <SN1PR0301MB16165146428CF6A8C48FF1B29D790@SN1PR0301MB1616.namprd03.prod.outlook.com>
References: <1439521930-28191-1-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1439521930-28191-1-git-send-email-dongsheng.wang@freescale.com>
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

Hi Scott,

Could you apply the patches?

Regards,
-Dongsheng

> -----Original Message-----
> From: Dongsheng Wang [mailto:dongsheng.wang@freescale.com]
> Sent: Friday, August 14, 2015 11:12 AM
> To: Wood Scott-B07421
> Cc: Jain Priyanka-B32167; devicetree@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org; Wang Dongsheng-B40534
> Subject: [PATCH v2 1/2] powerpc/85xx: Add binding for SCFG
>=20
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
>=20
> SCFG provides SoC specific configuration and status registers for
> the chip. Add this for powerpc platform.
>=20
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> ---
> *V2*
> - Remove scfg description in board.txt and create scfg.txt for scfg.
> - Change "fsl,<board>-scfg" to "fsl,<chip>-scfg"
>=20
> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/scfg.txt
> b/Documentation/devicetree/bindings/powerpc/fsl/scfg.txt
> new file mode 100644
> index 0000000..0532c46
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/powerpc/fsl/scfg.txt
> @@ -0,0 +1,18 @@
> +Freescale Supplement configuration unit (SCFG)
> +
> +SCFG is the supplemental configuration unit, that provides SoC specific
> +configuration and status registers for the chip. Such as getting PEX por=
t
> +status.
> +
> +Required properties:
> +
> +- compatible: should be "fsl,<chip>-scfg"
> +- reg: should contain base address and length of SCFG memory-mapped
> +registers
> +
> +Example:
> +
> +	scfg: global-utilities@fc000 {
> +		compatible =3D "fsl,t1040-scfg";
> +		reg =3D <0xfc000 0x1000>;
> +	};
> --
> 2.1.0.27.g96db324
