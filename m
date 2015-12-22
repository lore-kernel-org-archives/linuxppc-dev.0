Return-Path: <Igal.Liberman@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0119.outbound.protection.outlook.com [65.55.169.119])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0880C1A11C6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Dec 2015 19:53:28 +1100 (AEDT)
From: Liberman Igal <Igal.Liberman@freescale.com>
To: Shaohui Xie <shaohui.xie@nxp.com>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
CC: Scott Wood <scottwood@freescale.com>, Madalin-Cristian Bucur
 <madalin.bucur@freescale.com>, Shaohui Xie <Shaohui.Xie@freescale.com>
Subject: RE: [PATCH] powerpc/mpc85xx: Add pcsphy nodes to FManV3 device tree
Date: Tue, 22 Dec 2015 08:53:21 +0000
Message-ID: <DM2PR03MB509BC216FC7290C255B94CBE6E50@DM2PR03MB509.namprd03.prod.outlook.com>
References: <1450655851-6556-1-git-send-email-igal.liberman@freescale.com>
 <VI1PR04MB1664BA0097C2C574F084F544E8E50@VI1PR04MB1664.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB1664BA0097C2C574F084F544E8E50@VI1PR04MB1664.eurprd04.prod.outlook.com>
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



Regards,
Igal Liberman

> -----Original Message-----
> From: Shaohui Xie [mailto:shaohui.xie@nxp.com]
> Sent: Tuesday, December 22, 2015 8:27 AM
> To: Liberman Igal-B31950 <Igal.Liberman@freescale.com>;
> devicetree@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> Cc: Wood Scott-B07421 <scottwood@freescale.com>; Bucur Madalin-
> Cristian-B32716 <madalin.bucur@freescale.com>; Xie Shaohui-B21989
> <Shaohui.Xie@freescale.com>
> Subject: RE: [PATCH] powerpc/mpc85xx: Add pcsphy nodes to FManV3
> device tree
>=20
> > @@ -55,6 +55,7 @@ fman@400000 {
> >  		reg =3D <0xe0000 0x1000>;
> >  		fsl,fman-ports =3D <&fman0_rx_0x08 &fman0_tx_0x28>;
> >  		ptp-timer =3D <&ptp_timer0>;
> > +		pcsphy-handle =3D <&pcsphy0>;
> >  	};
> >
> >  	mdio@e1000 {
> > @@ -62,5 +63,9 @@ fman@400000 {
> >  		#size-cells =3D <0>;
> >  		compatible =3D "fsl,fman-memac-mdio", "fsl,fman-xmdio";
> >  		reg =3D <0xe1000 0x1000>;
> > +
> > +		pcsphy0: ethernet-phy@0 {
> > +			reg =3D <0x0>;
> > +		};
> >  	};
> >  };
>=20
> [S.H] snip.
>=20
> >  	mdio@e1000 {
> > @@ -58,5 +59,9 @@ fman@400000 {
> >  		#size-cells =3D <0>;
> >  		compatible =3D "fsl,fman-memac-mdio", "fsl,fman-xmdio";
> >  		reg =3D <0xe1000 0x1000>;
> > +
> > +		pcsphy0: pcs-phy@0 {
> > +			reg =3D <0x0>;
> > +		};
> >  	};
> [S.H] Should use 'ethernet-phy', same as above.
>=20

I'll resubmit and fix this (pcs-phy ---> ethernet-phy).

Thank you,
Igal

> Thanks,
> Shaohui
