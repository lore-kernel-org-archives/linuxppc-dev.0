Return-Path: <waite@skycomputers.com>
Received: from sky.skycomputers.com (sky.skycomputers.com [198.4.246.2])
	by ozlabs.org (Postfix) with ESMTP id 9DC5767A67
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Mar 2005 04:57:37 +1100 (EST)
Received: from dayton (dayton [192.9.200.220])
	by sky.skycomputers.com (Postfix) with ESMTP id 87D2114F299
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Mar 2005 13:06:02 -0500 (EST)
From: Brian Waite <waite@skycomputers.com>
To: linuxppc-embedded@ozlabs.org
Date: Thu, 17 Mar 2005 12:47:16 -0500
References: <200503170953.02626.waite@skycomputers.com>
	<4239C1FD.7060308@mvista.com>
In-Reply-To: <4239C1FD.7060308@mvista.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1623100.YPrkHYiPxz";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200503171247.20161.waite@skycomputers.com>
Subject: Re: [PATCH] ppc32: 0/2 add support for Sky Computers HDPU Compute
	blade
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--nextPart1623100.YPrkHYiPxz
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 17 March 2005 12:44, Mark A. Greer wrote:
> Brian Waite wrote:
>=20
> >+#define HDPU_INTERNAL_SRAM_BASE               0xfbfc0000
> >+#define HDPU_INTERNAL_SRAM_SIZE               0x00040000
> > =20
> >
> I haven't gone through in detail yet but one thing I did notice was that=
=20
> you don't have the proper SRAM alignment or size.  The SRAM on the=20
> 64[34]60 is 2MB so it must be aligned on a boundary that's a multiple of=
=20
> 2MB.
>=20
Mark,=20
	Argh that is a carry over from a bad experiment in consolidating memory sp=
ace.=20
I don't use the SRAM for anything so it will not break the code so I will p=
rovide a patch on top=20
of the platform patch to fix this if that works for you.

Thanks
Brian

--nextPart1623100.YPrkHYiPxz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCOcKomxLCz0u+Ko8RAvvoAJ0dFQGj0/rqkqKTGwTrwtQI4PeIZACbBPu+
XOtJgnpwDg0MlCXosKf5PAE=
=2frV
-----END PGP SIGNATURE-----

--nextPart1623100.YPrkHYiPxz--
