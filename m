Return-Path: <michael@ellerman.id.au>
Subject: Re: where do 8250 serial port initialize its mapbase and membase
	when  booting?
From: Michael Ellerman <michael@ellerman.id.au>
To: "wilbur.chan" <wilbur512@gmail.com>
In-Reply-To: <AANLkTil2XkHxcryRNcnUDgYv5iZJD76GCUcvHOYe9l9O@mail.gmail.com>
References: <AANLkTil2XkHxcryRNcnUDgYv5iZJD76GCUcvHOYe9l9O@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-DL25sJTAlWow9GgG0YX5"
Date: Mon, 21 Jun 2010 10:13:32 +1000
Message-ID: <1277079212.1753.4.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, "chen.yu10" <chen.yu10@zte.com.cn>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-DL25sJTAlWow9GgG0YX5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2010-06-21 at 01:27 +0800, wilbur.chan wrote:
> linux 2.6.21.7
>=20
> where do serial 8250 port fill its membase and mapbase  fileds  in
> system initializing ?
>=20
..
> So I am really confused with serial 8250
> initializing----------------where do kernel apply membase and mapbase
> filed to  8250 port?

Probably serial_dev_init() in legacy_serial.c

cheers

--=-DL25sJTAlWow9GgG0YX5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkwerqwACgkQdSjSd0sB4dLPXgCfQyceC+cXHu9LB0grpqm7N1xD
SO4An059I3kAOLugrNNjs9OWXKcN3EWs
=rQ98
-----END PGP SIGNATURE-----

--=-DL25sJTAlWow9GgG0YX5--
