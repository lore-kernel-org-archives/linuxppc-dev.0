Return-Path: <Wei.Zhang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D3383DDDF3
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 15:19:24 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l8D5JIuI004387
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 22:19:19 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l8D5JHb7013633
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 00:19:18 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: 2.6.23-rc3 boot hang on MPC8641D
Date: Thu, 13 Sep 2007 13:19:17 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C85D808@zch01exm26.fsl.freescale.net>
In-Reply-To: <5850B6F4-61FD-4866-B50E-8F7FEA3FA9AD@kernel.crashing.org>
References: <12648489.post@talk.nabble.com><46B96294322F7D458F9648B60E15112C85D7FB@zch01exm26.fsl.freescale.net><12648696.post@talk.nabble.com>
	<5850B6F4-61FD-4866-B50E-8F7FEA3FA9AD@kernel.crashing.org>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>, "sivaji" <rameshmrm@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Yes, It's too old. Maybe not fully supports FDT. You can try the version
of Kumar said or in the BSP of Freescale released.

- zw

> -----Original Message-----
> From: linuxppc-dev-bounces+wei.zhang=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-dev-bounces+wei.zhang=3Dfreescale.com@ozlabs.or
> g] On Behalf Of Kumar Gala
> Sent: Thursday, September 13, 2007 1:11 PM
> To: sivaji
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: 2.6.23-rc3 boot hang on MPC8641D
>=20
>=20
> On Sep 12, 2007, at 11:52 PM, sivaji wrote:
>=20
> >
> >
> > Hi,
> >           I tired to move the dtb to 0x2000000, but the result was =20
> > same.
> > uboot version is 1.1.6
>=20
> seems like a pretty old u-boot.  Willing to try a 1.3.0-rc1?
>=20
> - k
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>=20
