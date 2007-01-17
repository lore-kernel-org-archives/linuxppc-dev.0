Return-Path: <DaveLiu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 88159DDF09
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 19:00:52 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l0H80pBu022561
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 01:00:51 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l0H80nAw016397
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 02:00:50 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Warnings when booting rc5 on a mpc83xx based board
Date: Wed, 17 Jan 2007 16:00:39 +0800
Message-ID: <995B09A8299C2C44B59866F6391D26355F3456@zch01exm21.fsl.freescale.net>
In-Reply-To: <F6AD7E21CDF4E145A44F61F43EE6D939C688E7@tmnt04.transmode.se>
From: "Liu Dave-r63238" <DaveLiu@freescale.com>
To: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>,
	"Li Yang-r58472" <LeoLi@freescale.com>,
	"linuxppc-dev Development" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When the OF will be stable? The OF is really painful for embedded
system.

> -----Original Message-----
> From: linuxppc-dev-bounces+daveliu=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-dev-bounces+daveliu=3Dfreescale.com@ozlabs.org]
>  On Behalf Of Joakim Tjernlund
> Sent: 2007?1?17? 3:58 PM
> To: Li Yang-r58472; linuxppc-dev Development
> Subject: RE: Warnings when booting rc5 on a mpc83xx based board
>=20
> > -----Original Message-----
> > From: Li Yang-r58472 [mailto:LeoLi@freescale.com]
> > Sent: 17 January 2007 07:10
> > To: Joakim Tjernlund; linuxppc-dev Development
> > Subject: RE: Warnings when booting rc5 on a mpc83xx based board
> >=20
> > Please try:
> >=20
> > --- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
> > +++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
> > @@ -103,7 +103,7 @@ static void __init=20
> mpc832x_sys_setup_arch(void) =20
> > #ifdef CONFIG_QUICC_ENGINE
> >         qe_reset();
> >=20
> > -       if ((np =3D of_find_node_by_name(np, "par_io")) !=3D NULL) {
> > +       if ((np =3D of_find_node_by_name(NULL, "par_io")) !=3D NULL) =
{
> >                 par_io_init(np);
> >                 of_node_put(np);
> >=20
> > - Leo
>=20
> Thanks, this did fix the problem.
>=20
> Kumar, FYI your proposal had no effect.
>=20
>  Jocke
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>=20
