Return-Path: <shaohui.xie@nxp.com>
Received: from emea01-am1-obe.outbound.protection.outlook.com
 (mail-am1on0083.outbound.protection.outlook.com [157.56.112.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C29E61A1276
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Dec 2015 20:02:07 +1100 (AEDT)
From: Shaohui Xie <shaohui.xie@nxp.com>
To: Igal Liberman <Igal.Liberman@freescale.com>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
CC: Scott Wood <scottwood@freescale.com>, Madalin-Cristian Bucur
 <madalin.bucur@freescale.com>, "shaohui.xie@freescale.com"
 <shaohui.xie@freescale.com>
Subject: RE: [PATCH] powerpc/mpc85xx: Add pcsphy nodes to FManV3 device tree
Date: Tue, 22 Dec 2015 06:26:59 +0000
Message-ID: <VI1PR04MB1664BA0097C2C574F084F544E8E50@VI1PR04MB1664.eurprd04.prod.outlook.com>
References: <1450655851-6556-1-git-send-email-igal.liberman@freescale.com>
In-Reply-To: <1450655851-6556-1-git-send-email-igal.liberman@freescale.com>
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

> @@ -55,6 +55,7 @@ fman@400000 {
>  		reg =3D <0xe0000 0x1000>;
>  		fsl,fman-ports =3D <&fman0_rx_0x08 &fman0_tx_0x28>;
>  		ptp-timer =3D <&ptp_timer0>;
> +		pcsphy-handle =3D <&pcsphy0>;
>  	};
>=20
>  	mdio@e1000 {
> @@ -62,5 +63,9 @@ fman@400000 {
>  		#size-cells =3D <0>;
>  		compatible =3D "fsl,fman-memac-mdio", "fsl,fman-xmdio";
>  		reg =3D <0xe1000 0x1000>;
> +
> +		pcsphy0: ethernet-phy@0 {
> +			reg =3D <0x0>;
> +		};
>  	};
>  };

[S.H] snip.

>  	mdio@e1000 {
> @@ -58,5 +59,9 @@ fman@400000 {
>  		#size-cells =3D <0>;
>  		compatible =3D "fsl,fman-memac-mdio", "fsl,fman-xmdio";
>  		reg =3D <0xe1000 0x1000>;
> +
> +		pcsphy0: pcs-phy@0 {
> +			reg =3D <0x0>;
> +		};
>  	};
[S.H] Should use 'ethernet-phy', same as above.

Thanks,
Shaohui
