Return-Path: <B10812@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 31FAA1007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Jun 2010 17:30:05 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o5G7TvR4028102 for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Jun 2010 00:29:57 -0700 (MST)
Received: from zin33exm24.fsl.freescale.net (zin33exm24.ap.freescale.net
	[10.232.192.24])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o5G7dkk1004611
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Jun 2010 02:39:47 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] e500v2 36 bit large physical HID0[EN_MAS7_UPDATE]
Date: Wed, 16 Jun 2010 12:59:52 +0530
Message-ID: <8660DA277DC57B4BAAC78225F03146B6AB1B5C@zin33exm24.fsl.freescale.net>
In-Reply-To: <4C187616.4000303@neli.hopto.org>
References: <4C187616.4000303@neli.hopto.org>
From: "Aggrwal Poonam-B10812" <B10812@freescale.com>
To: "Micha Nelissen" <micha@neli.hopto.org>, <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From:
linuxppc-dev-bounces+poonam.aggrwal=3Dfreescale.com@lists.ozlabs.org
> [mailto:linuxppc-dev-
> bounces+poonam.aggrwal=3Dfreescale.com@lists.ozlabs.org] On Behalf Of
Micha
> Nelissen
> Sent: Wednesday, June 16, 2010 12:29 PM
> To: linuxppc-dev@lists.ozlabs.org
> Subject: [PATCH] e500v2 36 bit large physical HID0[EN_MAS7_UPDATE]
>=20
> Hi,
>=20
> Attached is a patch to fix large physical address support for the
e500v2
> core. When >4GB addresses are used, the MAS7 register needs to be
valid
> for tlbsx instruction usage.
>=20
> Please review and apply.
[Aggrwal Poonam] This is already being done by u-boot, should linux set
it again?
>=20
> Micha
