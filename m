Return-Path: <albrecht.dress@arcor.de>
Received: from smtp2.netcologne.de (smtp2.netcologne.de [194.8.194.112])
	by bilbo.ozlabs.org (Postfix) with ESMTP id C372CB7249
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 20 Jun 2009 03:57:56 +1000 (EST)
Received: from antares (xdsl-87-79-186-157.netcologne.de [87.79.186.157])
	by smtp2.netcologne.de (Postfix) with ESMTP id 8079C4342
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Jun 2009 19:28:20 +0200 (MEST)
Received: from antares (localhost [127.0.0.1])
	by antares (Postfix) with ESMTPS id 6C586BA042
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Jun 2009 19:28:20 +0200 (CEST)
Date: Fri, 19 Jun 2009 19:28:12 +0200
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: Re: Problem with memcpy on ppc8536
To: linuxppc-dev@lists.ozlabs.org
In-Reply-To: <4A3BC58A.7050408@missinglinkelectronics.com> (from
	lorenz@missinglinkelectronics.com on Fri Jun 19 19:06:18 2009)
Message-Id: <1245432500.3294.0@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="=-9KUEsSQ9CMqeonWXrWkE"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-9KUEsSQ9CMqeonWXrWkE
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 19.06.09 19:06 schrieb(en) Lorenz Kolb:
> Could you please try the following patch, I am quite sure that =20
> checking for > 4 was accidentially done within io.c instead of >=3D 4 =20
> as if it's 4 we still can copy a 32-bit word. Some hardware might not =20
> be happy about 8-bit accesses...

I submitted the same patch a while ago, see =20
<http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-May/072582.html> =20
and =20
<http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-June/073065.html>, =20
maybe you can add a tested/revied for it?

If it is a problem with *byte* accesses, you might want to have a look =20
at =20
<http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-June/072903.html>.

Best, Albrecht.

--=-9KUEsSQ9CMqeonWXrWkE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iD8DBQBKO8q0n/9unNAn/9ERAv/lAJ46Wuzz4RuXs/ERcQ5huZ/JnNED5QCeM2aX
Ah78LwfPsdutv5/GQhaa6jY=
=Nf+m
-----END PGP SIGNATURE-----

--=-9KUEsSQ9CMqeonWXrWkE--
