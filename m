Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7C07EDDFE4
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 19:33:55 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	lBE8XEog005898
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 01:33:14 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id lBE8X2Zu025791
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 02:33:03 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] add MPC837x MDS board default device tree
Date: Fri, 14 Dec 2007 16:33:00 +0800
Message-ID: <989B956029373F45A0B8AF029708189001B4DBA0@zch01exm26.fsl.freescale.net>
In-Reply-To: <4A496992-9B46-427D-8F40-447E92F8CA3D@kernel.crashing.org>
References: <1196851073-11801-1-git-send-email-leoli@freescale.com>
	<20071207020130.GA26412@localhost.localdomain>
	<4A496992-9B46-427D-8F40-447E92F8CA3D@kernel.crashing.org>
From: "Li Yang" <LeoLi@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>,
	"David Gibson" <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> >> +			device_type =3D "serial";
> >> +			compatible =3D "ns16550";
> >> +			reg =3D <4600 100>;
> >> +			clock-frequency =3D <0>;
> >> +			interrupts =3D <a 8>;
> >> +			interrupt-parent =3D < &ipic >;
> >> +		};
> >> +
> >> +		crypto@30000 {
> >> +			model =3D "SEC3";
> >> +			compatible =3D "talitos";
> >
> > This driver, also, needs fixing to recognize a better formatted=20
> > compatible property.
>=20
> Can you respin with David's changes as well as mirror my=20
> cleanup of the other 83xx/85xx .dts

Sure, but I'm taking one week off.  Will send you the updated one after
Christmas though.

- Leo
