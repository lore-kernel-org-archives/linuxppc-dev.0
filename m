Return-Path: <michael@ellerman.id.au>
Subject: Re: How to find macro defination in source code ?
From: Michael Ellerman <michael@ellerman.id.au>
To: "wilbur.chan" <wilbur512@gmail.com>
In-Reply-To: <AANLkTikS7AKQ0IaQQebh5MNlXLVEwQmsH8uk5GOwcckd@mail.gmail.com>
References: <AANLkTikS7AKQ0IaQQebh5MNlXLVEwQmsH8uk5GOwcckd@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-C89jglM3X+r4sEXQngAV"
Date: Sat, 19 Jun 2010 15:52:22 +1000
Message-ID: <1276926742.18166.3.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-C89jglM3X+r4sEXQngAV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2010-06-19 at 00:47 +0800, wilbur.chan wrote:
> For example, a macro in serial driver 8250.c , SERIAL_PORT_DFNS ,I
> can't find where it is implement.

It looks to be in 8250.c, so I don't know why you can't find it.

> Is there any solutions to find a macro defination in code ?

# make tags
# vi -t SERIAL_PORT_DFNS

Or in general:
http://ctags.sourceforge.net/

cheers

--=-C89jglM3X+r4sEXQngAV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkwcWxMACgkQdSjSd0sB4dKVaACfepFEZUSAD2j9Hw7M7ELjskQx
pq0Anj6X2slqThLOfQ4UGZ+Ku08fe+Xl
=oBYt
-----END PGP SIGNATURE-----

--=-C89jglM3X+r4sEXQngAV--
