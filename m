Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 02C3B67B19
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Apr 2005 23:53:35 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Wed, 6 Apr 2005 08:53:33 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B85933B@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "David Frascone" <dave@frascone.com>, <linuxppc-dev@ozlabs.org>
Subject: RE: Bogomips?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It's way low...
(output from a 8560 on 2.6.11):
cpu             : e500
revision        : 2.0 (pvr 8020 0020)
bogomips        : 823.29
Vendor          : Freescale Semiconductor
Machine         : mpc8560ads
clock           : 825MHz
PVR             : 0x80200020
SVR             : 0x80700020
PLL setting     : 0x5
Memory          : 256 MB=20

The 8260 one seems correct
cpu             : 82xx
revision        : 16.20 (pvr 8081 1014)
bogomips        : 191.48
core clock      : 289 MHz
CPM  clock      : 206 MHz
bus  clock      : 82 MHz

> -----Original Message-----
> From: linuxppc-dev-bounces@ozlabs.org=20
> [mailto:linuxppc-dev-bounces@ozlabs.org] On Behalf Of David Frascone
> Sent: Wednesday, April 06, 2005 08:12
> To: linuxppc-dev@ozlabs.org
> Subject: Bogomips?
>=20
>=20
> Can this be right?  I'm getting This from a MPC-8260 (/proc/cpuinfo):
>=20
> ------------------------------------------------
> cpu             : 82xx
> core clock      : 199 MHz
> CPM  clock      : 133 MHz
> bus  clock      : 33 MHz
> revision        : 1.1 (pvr 0081 0101)
> bogomips        : 133.12
> ------------------------------------------------
>=20
> And this from a MPC-8540
> ------------------------------------------------
> cpu             : e500
> revision        : 2.0 (pvr 8020 0020)
> bogomips        : 190.05
> Vendor          : Motorola SPS
> Machine         : mpc8540ads
> bus freq        : 666.666660 MHz
> PVR             : 0x80200020
> SVR             : 0x80300020
> PLL setting     : 0x4
> Memory          : 512 MB
> ------------------------------------------------
>=20
>=20
> The second one looks way low . . . any ideas?
>=20
> -Dave
>=20
> --=20
> David Frascone
>=20
> Gimme back my face! You're getting it ugly.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>=20
>=20
