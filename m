Return-Path: <marc.leeman@gmail.com>
Received: from lmailproxy04.edpnet.net (lmailproxy04.edpnet.net [212.71.1.197])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E70DADDECA
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jun 2007 03:13:50 +1000 (EST)
Date: Thu, 21 Jun 2007 19:13:40 +0200
From: Marc Leeman <marc.leeman@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: network load 8245 vs. 8347E
Message-ID: <20070621171340.GS5417@chiana.homelinux.org>
References: <20070621141519.GQ5417@chiana.homelinux.org>
	<0090CCD0-EBB4-4475-BF03-36AF41E2DDA1@kernel.crashing.org>
	<20070621155616.GR5417@chiana.homelinux.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Lez9QO3Seu3ycz0M"
In-Reply-To: <20070621155616.GR5417@chiana.homelinux.org>
Cc: linuxppc-dev@ozlabs.org
Reply-To: Marc Leeman <marc.leeman@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--Lez9QO3Seu3ycz0M
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Simply the load of the processor. The 8245 is running ppc/2.6.17, the
> 8347e is running powerpc/2.6.21.1.

Sorry, I'm confusing my boards: this particular board with the 8245
processor is running 2.4.34 [1].

so
8245: 2.4.34
8237e: 2.6.21.1

[1] the 2.4 line balanced the load better of multiple streams being
taken in wrt to the 2.6 kernels; this is the reason we stuck with 2.4
for this platform.

--=20
  greetz, marc
He claims to be a human from a planet called Erp.
	Aeryn - Premiere
chiana 2.6.18-4-ixp4xx #1 Tue Mar 27 18:01:56 BST 2007 GNU/Linux

--Lez9QO3Seu3ycz0M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGerHDUQpj09NWLeERAmEHAJ9yLw+LoxUyR2vjvsC7FGC5QsBJrACZATiU
cfzHD7bW4ur3qZQsIf0fp4k=
=FKNa
-----END PGP SIGNATURE-----

--Lez9QO3Seu3ycz0M--
