Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D7285DDDF9
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 14:43:21 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n2K3hIhe025846
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 20:43:18 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n2K3hF6g029824
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 22:43:16 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: suspend-to-mem on the mpc8349e-mitx-gp?
Date: Fri, 20 Mar 2009 11:43:12 +0800
Message-ID: <3A45394FD742FA419B760BB8D398F9ED29EB95@zch01exm26.fsl.freescale.net>
In-Reply-To: <20090319161101.GA2304@ld0162-tx32.am.freescale.net>
References: <ffa0ad880903182246y4323e31bv6109fbf748858af0@mail.gmail.com>
	<3A45394FD742FA419B760BB8D398F9ED29EAC6@zch01exm26.fsl.freescale.net>
	<20090319161101.GA2304@ld0162-tx32.am.freescale.net>
From: "Li Yang-R58472" <LeoLi@freescale.com>
To: "Wood Scott-B07421" <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Soohyung Cho <celius202@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Wood Scott-B07421=20
> Sent: Friday, March 20, 2009 12:11 AM
> To: Li Yang-R58472
> Cc: Soohyung Cho; linuxppc-dev@ozlabs.org
> Subject: Re: suspend-to-mem on the mpc8349e-mitx-gp?
>=20
> On Thu, Mar 19, 2009 at 12:24:26AM -0700, Li Yang-R58472 wrote:
> > > -----Original Message-----
> > > From: linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org
> > > [mailto:linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org]
> > > On Behalf Of Soohyung Cho
> > > Sent: Thursday, March 19, 2009 1:47 PM
> > > To: linuxppc-dev@ozlabs.org; Wood Scott-B07421
> > > Subject: suspend-to-mem on the mpc8349e-mitx-gp?
> > >=20
> > > Hello.
> > >=20
> > > I need to enable suspend-to-mem(deep sleep) on my=20
> mpc8349e-mitx-gp=20
> > > box.
> > > When I send "mem" message to /sys/power/state, the box=20
> seems to get=20
> > > stop.
> > > I think the box get stop when it executes suspend-asm.S codes.
> > >=20
> > > I know that the latest linux supports suspend-to-mem on the=20
> > > mpc8313erdb box well.
> > > Is it impossible to enable suspend-to-mem on the mpc8349e-mitx-gp?
> >=20
> > I don't think the MPC8349 hardware has the deep sleep functionality.
>=20
> However, the code should treat "mem" as "standby" on chips=20
> that don't support deep sleep.  What does the device tree=20

Well, shouldn't the valid() callback reject unsupported states instead
of covering up?

- Leo
