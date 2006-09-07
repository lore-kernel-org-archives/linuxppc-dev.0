Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id C7BF567B6F
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Sep 2006 18:25:18 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k878PGpb024604
	for <linuxppc-embedded@ozlabs.org>; Thu, 7 Sep 2006 01:25:16 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k878PE8c015280
	for <linuxppc-embedded@ozlabs.org>; Thu, 7 Sep 2006 03:25:15 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: MPC8360E USB Host Controller Driver
Date: Thu, 7 Sep 2006 16:25:47 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D14C78C@zch01exm20.fsl.freescale.net>
In-Reply-To: <16599.202.144.30.226.1157616213.squirrel@mail.gdatech.co.in>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: <n.balaji@gdatech.co.in>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> -----Original Message-----
> From:=20
> linuxppc-embedded-bounces+leoli=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-embedded-bounces+leoli=3Dfreescale.com@ozlabs.o
> rg] On Behalf Of n.balaji@gdatech.co.in
> Sent: Thursday, September 07, 2006 4:04 PM
> To: linuxppc-embedded@ozlabs.org
> Subject: MPC8360E USB Host Controller Driver
>=20
> Hi All,
>    I am working in MPC8360E processor board. I want the=20
> PowerQUICC II's Pro  USB Host controller Driver. In the=20
> manual, they told that this controller does not belong to=20
> UHCI or OHCI standard.

Yes, you can call it FHCI if you like. :)
>=20
>   I have doubt that whether Freescale has its own USB standard.

The interface is stated clearly in the UM.
>=20
>   Please give the link or patch for that driver.

There is an 8360 host driver in Freescale LTIB BSP.  Please find it on
www.freescale.com, if it has been released.

- Leo
