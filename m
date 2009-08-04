Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 19B30B6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  4 Aug 2009 12:31:29 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0B197DDD0B
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Aug 2009 12:31:29 +1000 (EST)
Subject: Re: Kernel fault with simple UIO interrupt driver in 2.6.30.4
From: Michael Ellerman <michael@ellerman.id.au>
To: Frank Prepelica <Frank.Prepelica@ubidyne.com>
In-Reply-To: <29DC34A6B43468409F5A371CFE34E849DFC9A1@ex01.ads.ubidyne.de>
References: <29DC34A6B43468409F5A371CFE34E849DFC9A1@ex01.ads.ubidyne.de>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-/4SX1oi2vobFo5LhjBt+"
Date: Tue, 04 Aug 2009 12:31:25 +1000
Message-Id: <1249353085.5517.29.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-/4SX1oi2vobFo5LhjBt+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2009-08-03 at 15:07 +0200, Frank Prepelica wrote:
> Hi all,
>=20
> due to a new revision of our custimized board, i need to port our current=
 kernel (2.6.24)
> to the latest kernel version 2.6.30.4.
>=20
> Among other things the UIO interrupt driver makes some trouble. The drive=
r runs
> smoothly on 2.6.24 but I'll get kernel faults when running in 2.6.30.4.

You seem to have forgotten to post the log of the oops :)

cheers


--=-/4SX1oi2vobFo5LhjBt+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkp3nX0ACgkQdSjSd0sB4dI2iACgoK33PC0GLKrVjLx/rSrnWS2L
AJsAoMA7Fo/QeihaukvtUkBU7zneMCvB
=dYO+
-----END PGP SIGNATURE-----

--=-/4SX1oi2vobFo5LhjBt+--
