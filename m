Return-Path: <vitorio@digitel.com.br>
Received: from hermes.digitel.com.br (hermes.digitel.com.br [200.198.105.36])
	by ozlabs.org (Postfix) with ESMTP id CA8F12BF23
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Jan 2005 00:05:13 +1100 (EST)
Received: from [10.10.10.160] by hermes.digitel.com.br (GMS
	9.01.3158/NU1492.00.9f6ce814) with ESMTP id althibaa for
	linuxppc-embedded@ozlabs.org; Tue, 4 Jan 2005 11:11:42 -0200
From: =?ISO-8859-1?Q?Lu=EDs_Vit=F3rio?= Cargnini <vitorio@digitel.com.br>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
In-Reply-To: <Pine.GSO.4.61.0501031717080.27452@waterleaf.sonytel.be>
References: <1104758458.14925.5.camel@vitorio>
	<Pine.GSO.4.61.0501031717080.27452@waterleaf.sonytel.be>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-eHKAYVpr0ErujqILPm2/"
Date: Tue, 04 Jan 2005 11:07:28 +0000
Message-Id: <1104836848.5622.8.camel@vitorio>
Mime-Version: 1.0
Subject: Re: Making a serial multiplexer (new driver)
Reply-To: vitorio@digitel.com.br
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-eHKAYVpr0ErujqILPm2/
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable

it can't be done in user space=20
why?
Because the multiplexer has an proprietary p=E0otocol 8-(
so i'll encapsulate the communication of 3 channels to communicate with
physical device and my user-level applications like pppd don't need to
know the mux protocol, this will be transparent for the user
applications.

On Mon, 2005-01-03 at 17:17 +0100, Geert Uytterhoeven wrote:
> On Mon, 3 Jan 2005, [ISO-8859-1] Lu=EDs Vit=F3rio Cargnini wrote:
> > Hi i need to write a driver that must multiplex an serial channel my
> > driver will have  3 interfaces and i must communicate with another
> > interface  (midleware) like /dev/ttyS2 for example, how could i write a
> > driver that will communicate with my existing uart ???
> >=20
> > i have a component that could be multiplexed in 3 logical channels thro=
w
> > my single physical channel that are accessed with a normal serial
> > interface using uart, how could this be possible ?
> > this is necessary to be transparent to software user level.
>=20
> Do it in userspace using fifos?
>=20
> Gr{oetje,eeting}s,
>=20
> 						Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>=20
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
> 							    -- Linus Torvalds
--=20
Lu=EDs Vit=F3rio Cargnini <vitorio@digitel.com.br>
Digitel S/A

--=-eHKAYVpr0ErujqILPm2/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBB2njwyHSZZ0hdDzQRAhzVAJ450scCBfihNBEFjapeQM40Xyds2gCdF8/B
Khi+8ZrlOG0QqKEEnEXn7E8=
=2DPT
-----END PGP SIGNATURE-----

--=-eHKAYVpr0ErujqILPm2/--
