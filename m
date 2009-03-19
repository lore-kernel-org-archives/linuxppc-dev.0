Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 09AD7DDE31
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 18:24:36 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n2J7OUO1002079
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 00:24:31 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n2J7OSJF024277
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 02:24:29 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: suspend-to-mem on the mpc8349e-mitx-gp?
Date: Thu, 19 Mar 2009 15:24:26 +0800
Message-ID: <3A45394FD742FA419B760BB8D398F9ED29EAC6@zch01exm26.fsl.freescale.net>
In-Reply-To: <ffa0ad880903182246y4323e31bv6109fbf748858af0@mail.gmail.com>
References: <ffa0ad880903182246y4323e31bv6109fbf748858af0@mail.gmail.com>
From: "Li Yang-R58472" <LeoLi@freescale.com>
To: "Soohyung Cho" <celius202@gmail.com>, <linuxppc-dev@ozlabs.org>,
	"Wood Scott-B07421" <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org]=20
> On Behalf Of Soohyung Cho
> Sent: Thursday, March 19, 2009 1:47 PM
> To: linuxppc-dev@ozlabs.org; Wood Scott-B07421
> Subject: suspend-to-mem on the mpc8349e-mitx-gp?
>=20
> Hello.
>=20
> I need to enable suspend-to-mem(deep sleep) on my=20
> mpc8349e-mitx-gp box.
> When I send "mem" message to /sys/power/state, the box seems=20
> to get stop.
> I think the box get stop when it executes suspend-asm.S codes.
>=20
> I know that the latest linux supports suspend-to-mem on the=20
> mpc8313erdb box well.
> Is it impossible to enable suspend-to-mem on the mpc8349e-mitx-gp?

I don't think the MPC8349 hardware has the deep sleep functionality.

- Leo
