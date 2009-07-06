Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 90D24B7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  6 Jul 2009 19:05:36 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7907DDDD01
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Jul 2009 19:05:36 +1000 (EST)
Subject: Re: sym scsi driver problem with 2.6.26 or newer debian kernel on
	p610 (fwd)
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1246143260.22312.66.camel@pasglop>
References: <Pine.LNX.4.64.0906141105050.4412@axis700.grange>
	<4A38B883.80507@ktk.bme.hu>  <4A3F4A77.6070704@ktk.bme.hu>
	<1245719890.4017.26.camel@pasglop> <1245724218.4017.35.camel@pasglop>
	<1245794228.10356.31.camel@pasglop> <1245799792.10356.42.camel@pasglop>
	<1245822826.9237.62.camel@concordia>
	<1245823019.10356.69.camel@pasglop>
	<1245824392.9237.85.camel@concordia>  <4A465AF5.9000606@ktk.bme.hu>
	<1246143260.22312.66.camel@pasglop>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-5YcWeRkwkjr+wNlGwgkT"
Date: Mon, 06 Jul 2009 19:05:35 +1000
Message-Id: <1246871135.4859.1.camel@concordia>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	debian-powerpc@lists.debian.org,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>, blackluck@ktk.bme.hu
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-5YcWeRkwkjr+wNlGwgkT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2009-06-28 at 08:54 +1000, Benjamin Herrenschmidt wrote:
> On Sat, 2009-06-27 at 19:46 +0200, Laszlo Fekete wrote:
> > Hello!
> >=20
> > Thank you very much, this patch works me too.
> >=20
> > Maybe this patch will be in the debian kernel someday?
>=20
> The patch isn't actually correct just yet :-) Michael will
> be posting a proper one next week.

.. or the week after:

http://patchwork.ozlabs.org/patch/29475/

cheers

--=-5YcWeRkwkjr+wNlGwgkT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkpRvloACgkQdSjSd0sB4dKvLwCfdF1XJ/DS6iC3VUTYGcZI192X
EoUAn2zvV/xAh97OgGcZuLfhy7aqFdG+
=Sl1z
-----END PGP SIGNATURE-----

--=-5YcWeRkwkjr+wNlGwgkT--
