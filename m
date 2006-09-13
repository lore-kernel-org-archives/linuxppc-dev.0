Return-Path: <DaveLiu@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id D853D67B5F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Sep 2006 19:43:32 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k8D9hUUC029697 for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Sep 2006 02:43:30 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k8D9hS39012569
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Sep 2006 04:43:29 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: JTAG Flash programmer for MPC8248
Date: Wed, 13 Sep 2006 17:43:26 +0800
Message-ID: <995B09A8299C2C44B59866F6391D263516B886@zch01exm21.fsl.freescale.net>
In-Reply-To: <200609131138.45308.laurent.pinchart@tbox.biz>
From: "Liu Dave-r63238" <DaveLiu@freescale.com>
To: "Laurent Pinchart" <laurent.pinchart@tbox.biz>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> Hi everybody,
>=20
> I'm looking for a solution to program flash memory on a=20
> MPC8248 board for production.
>=20
> I remember hearing about a JTAG flash programmer that used=20
> boundary scan to control the flash signals, but can't find=20
> any reference to it anymore.

Look this
http://www.intellitech.com/products/eclipseboundaryscanflash.asp
See if this is what you need.

I think this tool is not cheaper than BDI2000. and need 8248 BSDL.


> I know the BDI2000 is able to program the target flash=20
> memory, but I'm looking for a less expensive solution (I=20
> don't need debugging capabilities, just a plain flash programmer).
>=20
> Any help will be appreciated.
>=20
> Laurent Pinchart
