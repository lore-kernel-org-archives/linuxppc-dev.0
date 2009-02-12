Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 419BADDDAC
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 16:40:52 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n1C5emKO021706
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 22:40:49 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n1C5elOi003891
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 23:40:48 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] powerpc/83xx: Revive Marvell PHY option on MPC8313E-RDB
	rev. C boards
Date: Thu, 12 Feb 2009 13:40:47 +0800
Message-ID: <3A45394FD742FA419B760BB8D398F9ED1D2D8B@zch01exm26.fsl.freescale.net>
In-Reply-To: <60C07231-C830-440E-8425-D3069AB3620B@kernel.crashing.org>
References: <20090205201040.GB3425@oksana.dev.rtsoft.ru>
	<2a27d3730902082347n7f0eb48dq8c4ecccda290f9c8@mail.gmail.com>
	<ED186496-3882-4E87-9BEC-B56FE09C5827@kernel.crashing.org>
	<20090210151047.GA25086@oksana.dev.rtsoft.ru>
	<60C07231-C830-440E-8425-D3069AB3620B@kernel.crashing.org>
From: "Li Yang-R58472" <LeoLi@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
> Sent: Thursday, February 12, 2009 1:25 PM
> To: Li Yang-R58472
> Cc: linuxppc-dev list; Anton Vorontsov
> Subject: Re: [PATCH] powerpc/83xx: Revive Marvell PHY option=20
> on MPC8313E-RDB rev. C boards
>=20
>=20
> On Feb 10, 2009, at 9:10 AM, Anton Vorontsov wrote:
>=20
> >
> > Li, thanks for heads-up!
> >
> > One thing though: documentation says that Marvell PHY=20
> address is 0x3,=20
> > while old device tree and this patch:
> >
> >=20
> http://www.bitshrine.org/gpp/linux-fsl-2.6.23-MPC8313ERDB-add-default-
> > dts.patch
> >
> > says "0x1"... I don't have any rev. C boards, so it would=20
> be great if=20
> > somebody could confirm that 0x1 is the actual address.

The correct address is 0x3.  The previous patch in revB BSP used a guess
value before the revC documentation is available.  The latest BSP has
been updated to use the correct address.

- Leo
