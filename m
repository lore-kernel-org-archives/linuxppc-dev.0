Return-Path: <jason.mcmullan@timesys.com>
Received: from exchange.timesys.com (mail.timesys.com [65.117.135.102])
	by ozlabs.org (Postfix) with ESMTP id 34A7267A7B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Mar 2005 00:46:43 +1100 (EST)
From: Jason McMullan <jason.mcmullan@timesys.com>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <ba2549a1f7b9f73004d8d6e52415aee4@freescale.com>
References: <20050322211839.6A3DCC1510@atlas.denx.de>
	<ba2549a1f7b9f73004d8d6e52415aee4@freescale.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-/LA8Q3zfMEEdd4RE0rKG"
Date: Wed, 23 Mar 2005 08:46:42 -0500
Message-Id: <1111585602.2987.79.camel@ad.doubleclick.net>
Mime-Version: 1.0
Cc: linuxppc-embedded linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] CPM2 cleanups
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-/LA8Q3zfMEEdd4RE0rKG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-03-22 at 23:46 -0600, Kumar Gala wrote:
> Jason, why did you bother to implement these functions, they dont=20
> provide any value for us?
>=20
> It looks like startup() & shutdown() are only used in IRQ probing code=20
> or code in which enable/disable will be used instead.

startup/shutdown is used in the 'IRQ threads' patch we use at
TimeSys.


--=20
Jason McMullan <jason.mcmullan@timesys.com>
TimeSys Corporation


--=-/LA8Q3zfMEEdd4RE0rKG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCQXNC8/0vJ5szK6kRAnitAJ0XdJWVL4U04QScJh0WmTj1RpzyWwCbBwM2
PLXkjtTQ4RKkjcoCLC5WGTc=
=OOCH
-----END PGP SIGNATURE-----

--=-/LA8Q3zfMEEdd4RE0rKG--
