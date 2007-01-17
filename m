Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (147.175.241.83.in-addr.dgcsystems.net
	[83.241.175.147]) by ozlabs.org (Postfix) with ESMTP id 8153EDDEF5
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 18:57:33 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Warnings when booting rc5 on a mpc83xx based board
Date: Wed, 17 Jan 2007 08:57:30 +0100
Message-ID: <F6AD7E21CDF4E145A44F61F43EE6D939C688E7@tmnt04.transmode.se>
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "Li Yang-r58472" <LeoLi@freescale.com>,
	"linuxppc-dev Development" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Li Yang-r58472 [mailto:LeoLi@freescale.com]=20
> Sent: 17 January 2007 07:10
> To: Joakim Tjernlund; linuxppc-dev Development
> Subject: RE: Warnings when booting rc5 on a mpc83xx based board
>=20
> Please try:
>=20
> --- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
> +++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
> @@ -103,7 +103,7 @@ static void __init mpc832x_sys_setup_arch(void)
>  #ifdef CONFIG_QUICC_ENGINE
>         qe_reset();
>=20
> -       if ((np =3D of_find_node_by_name(np, "par_io")) !=3D NULL) {
> +       if ((np =3D of_find_node_by_name(NULL, "par_io")) !=3D NULL) {
>                 par_io_init(np);
>                 of_node_put(np);
>=20
> - Leo

Thanks, this did fix the problem.

Kumar, FYI your proposal had no effect.

 Jocke
