Return-Path: <johannes@sipsolutions.net>
Subject: Re: [RFC/PATCH] powerpc: Add irqtrace support to 32-bit powerpc
From: Johannes Berg <johannes@sipsolutions.net>
To: Dale Farnsworth <dale@farnsworth.org>
In-Reply-To: <20080404212952.GA15454@farnsworth.org>
References: <20080201195040.GA8950@farnsworth.org>
	<1207145738.3957.2.camel@johannes.berg>
	<1207337598.19189.77.camel@johannes.berg>
	<20080404212952.GA15454@farnsworth.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-/INBbWlFvjS0PYfSwI1G"
Date: Fri, 04 Apr 2008 23:35:16 +0200
Message-Id: <1207344916.3625.14.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Benjamin Herrenschmidt <benh@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-/INBbWlFvjS0PYfSwI1G
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> My apologies, Johannes.  I made some unwarranted assumptions about
> register usage in the lowest-level exception handlers.  While it worked
> on my 7447 board, I saw similar random failures on the 85xx (booke) syste=
m
> I tried.

No harm done, just wanted to give it a try and let you know it failed.

> Thanks for testing this.
>=20
> I'll follow up with a revised patch.

Great, thanks! I'll test that as well then.

johannes

--=-/INBbWlFvjS0PYfSwI1G
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR/afE6Vg1VMiehFYAQLVfhAAlqsouHiVtqCbLQ1VwAERCjsOQwz0gD+a
AbGSOivOVgpD4xc/jonjZui8dLCaP4TJT3P4CfEJTU6cNYd76h5TmUqNkNjcRIY8
aXstpqotOtIjDn+m4W/6LavVKK4tvw28CkhcCR3LSqo6Pr35o9IS2zKNW66A6n/Q
0CasXxHUBLid6NleXP9yF0FG4mmkpWYUDzli5YI942eXlxRESL4XF7R6hHktSxcp
lVDCzx1wdybxaLmtgtcmPBqotElTnWcAvjnqFTKLVenp+VqbmIK8j2hxdYXGTaZr
aZTehIJMawHxE5YytN6clOndP2tulYDrheVi1FfpLVtUFRNUbZ588ixBTdkJ2jQI
J8CaJAy9GzCNccFTlUv+3OibfyeUOktSVzu5fi2jeE3PAvIEhSPN1yQdZBMvBz6T
EASi5sSVhOZ3wBcpVPj+zdDpIKfaX4UVAtIhFXl7ll+FvfYEayxj+QdGJx7WVDnn
jUtYQtU2eIbjRD5+ooCjYSWMKKtA1SpnDm8a9C6rcxjR+QL1GYuvaXxmbzHrEv64
B3WHX0I8O5G0g20tQ+5XqYz+vpjyFKzpZUK2bcYUZftucXLQnUIFK47MdoTrvNGT
OKmBn8ov/jtMBGm2+SaIlEbOViITZXyFQl3eKi4Ef5alyyZkrnOgn/kvoYNLMFr1
V1gMbjBoSW8=
=ZLxM
-----END PGP SIGNATURE-----

--=-/INBbWlFvjS0PYfSwI1G--
