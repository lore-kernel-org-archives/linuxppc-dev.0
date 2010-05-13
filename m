Return-Path: <michael@ellerman.id.au>
Subject: Re: "event-scan failed" logflood
From: Michael Ellerman <michael@ellerman.id.au>
To: pacman@kosh.dhis.org
In-Reply-To: <20100513041329.1972.qmail@kosh.dhis.org>
References: <20100513041329.1972.qmail@kosh.dhis.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-DbJS/pRn98UK14hXUdxy"
Date: Thu, 13 May 2010 16:04:45 +1000
Message-ID: <1273730685.25436.66.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-DbJS/pRn98UK14hXUdxy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2010-05-12 at 23:13 -0500, pacman@kosh.dhis.org wrote:
> I upgraded the kernel on my Pegasos from 2.6.32 to 2.6.33 and now it send=
s
> the message "event-scan failed" to the kernel log about 60 times per seco=
nd
> as long as it's running.
>=20
> The message comes from arch/powerpc/kernel/rtasd.c but I don't know what'=
s
> going on in there so I can't say much more about it.
>=20
> How may I help find the cause of this problem?
>=20
> (Or alternatively: what is the correct way to disable this "event-scan"? =
I
> suspect it's not really necessary since it didn't exist in the previous
> kernel version, and the system is running perfectly aside from the error
> message flood.)
>=20

It's probably caused by 3d541c4b7f6efd55a98189afd1b2f1c9d048c1b3.

Is Pegasos a chrp, I can't remember. It did get called in the old chrp
code, and the comments suggest you have to call it.

It's not obvious looking at the diff why it would be failing now but
didn't previously.

cheers

--=-DbJS/pRn98UK14hXUdxy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkvrln0ACgkQdSjSd0sB4dKgNQCgnAWZ7LfCy7oU8uyn186loUpu
xyEAoIu2lVdNNKurK1Rqea+U0RBgiqvE
=fd8Y
-----END PGP SIGNATURE-----

--=-DbJS/pRn98UK14hXUdxy--
