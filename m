Return-Path: <albrecht.dress@arcor.de>
Received: from smtp4.netcologne.de (smtp4.netcologne.de [194.8.194.137])
	by ozlabs.org (Postfix) with ESMTP id 733B0DDF0D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Feb 2008 07:01:45 +1100 (EST)
Received: from antares.localdomain (xdsl-87-78-247-218.netcologne.de
	[87.78.247.218])
	by smtp4.netcologne.de (Postfix) with ESMTP id 11F2CDB7DD
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Feb 2008 21:01:43 +0100 (CET)
Received: from antares.localdomain (localhost.localdomain [127.0.0.1])
	by antares.localdomain (Postfix) with ESMTP id AC9C432F531
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Feb 2008 21:01:42 +0100 (CET)
Date: Mon, 25 Feb 2008 21:01:42 +0100
From: =?UTF-8?q?Albrecht_Dre=C3=9F?= <albrecht.dress@arcor.de>
Subject: Re: Status of 5200B and 440 Kernel Support
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <20080224073800.4bdb30ac@zod.rchland.ibm.com> (from
	jwboyer@linux.vnet.ibm.com on Sun Feb 24 14:38:00 2008)
Message-Id: <1203969702l.2318l.2l@antares.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="=-AjNjr+qBd9XelJykHECA"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--=-AjNjr+qBd9XelJykHECA
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Josh,

thanks a lot for your answers!

Am 24.02.08 14:38 schrieb(en) Josh Boyer:
> > - MTD/NAND controller
>=20
> NOR flash works.  NAND needs some additional code.

Hmm - does it mean it's currently under development?  I couldn't find =20
anything in make xconfig for stock 2.6.24 (running on a PowerMac, but =20
of course with the 44x enabled).

> UART works.  IIC has recent patches.  No idea about SPI.

SPI is probably not too hard.  I did some hacks for a slave in an =20
arm920 based environment for that.  Here I would need master mode, so I =20
guess some of the infrastructure form drivers/spi can be used.

> > - local external bus (not PCI) DMA
>=20
> DMA to the EBC for what?

To load data from an external measurement device which should be =20
connected to the cpu's external bus at a fixed address.  It will =20
produce "bursts" which should be shifted out of it without cpu =20
intervention if possible, as it does not have a big fifo, and I must =20
not lose data.

Thanks,
Albrecht.

--=-AjNjr+qBd9XelJykHECA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.8 (GNU/Linux)

iD8DBQBHwx6mn/9unNAn/9ERAjNrAKCsvQxwO1aWAxXSeN67+xtEuwEJbACggr55
uXiSfbXLQcv3du6kyEELqL0=
=k8vP
-----END PGP SIGNATURE-----

--=-AjNjr+qBd9XelJykHECA--
