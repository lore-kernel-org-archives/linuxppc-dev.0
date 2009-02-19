Return-Path: <Poonam.Aggrwal@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 53072DDE11
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Feb 2009 18:25:09 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n1J7P6PX004683
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Feb 2009 00:25:06 -0700 (MST)
Received: from zin33exm24.fsl.freescale.net (zin33exm24.ap.freescale.net
	[10.232.192.24])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n1J7P4Hp002085
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Feb 2009 01:25:05 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Newby trying to get Ethernet going on MPC83xx series device.
Date: Thu, 19 Feb 2009 12:55:04 +0530
Message-ID: <FD3D453EC8A8D5479E7E063D31E2FA4426866A@zin33exm24.fsl.freescale.net>
In-Reply-To: <2a27d3730902182319i2c59d68dk98e7975714f80549@mail.gmail.com>
References: <DE0CCFFBFF707949BEABD4537A14ACBA0C04B40549@mailsvr>
	<3A45394FD742FA419B760BB8D398F9ED246F06@zch01exm26.fsl.freescale.net>
	<FD3D453EC8A8D5479E7E063D31E2FA44268653@zin33exm24.fsl.freescale.net>
	<DE0CCFFBFF707949BEABD4537A14ACBA0C04B4054B@mailsvr>
	<2a27d3730902182319i2c59d68dk98e7975714f80549@mail.gmail.com>
From: "Aggrwal Poonam-B10812" <Poonam.Aggrwal@freescale.com>
To: "Li Yang-R58472" <LeoLi@freescale.com>,
	"Dushara Jayasinghe" <DusharaJ@optiscan.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Probably better would be to check the board file for  mpc834x_mds.c

I mean just cross that you probe all the buses which are on the device.
What is fsl,pq2pro-localbus? Do u have such node in dts as the
mpc8349_itx has.

> -----Original Message-----
> From: pku.leo@gmail.com [mailto:pku.leo@gmail.com] On Behalf=20
> Of Li Yang-R58472
> Sent: Thursday, February 19, 2009 12:50 PM
> To: Dushara Jayasinghe
> Cc: linuxppc-dev@ozlabs.org; Aggrwal Poonam-B10812
> Subject: Re: Newby trying to get Ethernet going on MPC83xx=20
> series device.
>=20
> On Thu, Feb 19, 2009 at 2:58 PM, Dushara Jayasinghe=20
> <DusharaJ@optiscan.com> wrote:
> > That did it.
> >
> >
> >
> > I based my board specific file on mpc834x_itx.c which had
> >
> >
> >
> > static struct of_device_id __initdata mpc834x_itx_ids[] =3D {
> >
> >                 { .compatible =3D "fsl,pq2pro-localbus", },
> >
> >                 { .compatible =3D "simple-bus", },
> >
> >                 {},
> >
> > };
> >
> >
> >
> > Don't know if this is broken?
>=20
> It's not broken as long as you have compatible =3D "simple-bus"=20
> for your soc node.
>=20
> - Leo
>=20
>=20
