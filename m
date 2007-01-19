Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id DC447DDE41
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Jan 2007 07:37:45 +1100 (EST)
Date: Fri, 19 Jan 2007 23:34:54 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: "Russell McGuire" <rmcguire@uwbt.com>
Subject: Re: MPC83xx:  ns16550.c - 'SERIAL_PORT_DFNS' undeclared?
Message-ID: <20070119233454.6c096bb3@localhost.localdomain>
In-Reply-To: <001001c73c06$5fbf2060$6405a8c0@absolut>
References: <000801c73c00$01d6cf30$6405a8c0@absolut>
	<1169236694.3029.49.camel@saruman.qstreams.net>
	<001001c73c06$5fbf2060$6405a8c0@absolut>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_.qi8RkdCrsK=Sia=BNSgDaO";
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--Sig_.qi8RkdCrsK=Sia=BNSgDaO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Jan 2007 12:14:04 -0800
Russell McGuire wrote:

> Ben,
>=20
> That could be the problem
>=20
> I am building using ARCH=3Dppc
>=20
> What is the difference between the two?
Newer targets appear within arch/powerpc... Concerning your question,=20
you seem to add new board hence you'll have to do those SERIAL_PORT_DFNS
in board-specific header file - grep for them inside arch/ppc for reference=
 (if
that code is still there of course).

OTOH, if you are able to replace/update your firmware, I'd follow powerpc w=
ay.
Difference is FAQ I guess, please look around this list.

>=20
> -----Original Message-----
And, uhm, top quoting is not good. I know telling that fact to Lookout DIst=
ress is a challenge but anyway :)

--
Thanks, Vitaly
> From: Ben Warren [mailto:bwarren@qstreams.com]=20
> Sent: Friday, January 19, 2007 11:58 AM
> To: Russell McGuire
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: MPC83xx: ns16550.c - 'SERIAL_PORT_DFNS' undeclared?
>=20
>=20
> Russell,
>=20
> On Fri, 2007-01-19 at 11:28 -0800, Russell McGuire wrote:
>=20
> >=20
> > arch/ppc/boot/common/ns16550.c  error: 'SERIAL_PORT_DFNS' undeclared
> > here ..
> >=20
>=20
> I don't think you should be building any code there...  Are you using
> ARCH=3Dpowerpc (you should be)
>=20
> regards,
> Ben
>=20
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

--Sig_.qi8RkdCrsK=Sia=BNSgDaO
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFsStuuOg9JvQhSEsRAp6cAJ9kz1uJfqSLQ7FX7TkKBqYA8D6JtwCfaFY3
iBJz6qqQ46cC/RoYVSAAVsY=
=knNs
-----END PGP SIGNATURE-----

--Sig_.qi8RkdCrsK=Sia=BNSgDaO--
