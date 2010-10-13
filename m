Return-Path: <michael@ellerman.id.au>
Subject: Re: Questions on interrupt vector assignment on MPC8641D
From: Michael Ellerman <michael@ellerman.id.au>
To: david.hagood@gmail.com
In-Reply-To: <8f62561e16a507967978112d03fe5867.squirrel@localhost>
References: <6e7b840fa55e4fba421e1b1cea2716ec.squirrel@localhost>
	<1682399277683944B902B3657D2FCE21654570D791@CAREXCLUSTER03.ATL.CW.LOCAL>
	<20100921170700.53a99e56@udp111988uds.am.freescale.net>
	<fe4c3e4086132d746b79670f236302f1.squirrel@localhost>
	<20101007152626.4e834d43@udp111988uds.am.freescale.net>
	<adaf806ee1c11621dbb51246bef0acd8.squirrel@localhost>
	<4CB2DE2B.7040504@windriver.com>
	<8f62561e16a507967978112d03fe5867.squirrel@localhost>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-h9A/RH7kG4HH33R5GLTK"
Date: Wed, 13 Oct 2010 12:10:15 +1100
Message-ID: <1286932215.24583.7.camel@concordia>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
	"tiejun.chen" <tiejun.chen@windriver.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-h9A/RH7kG4HH33R5GLTK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2010-10-11 at 09:44 -0500, david.hagood@gmail.com wrote:
> > You should define MSI device nodes on your target dts. And you can refe=
r
> > to the
> > file, mpc8572ds.dts.
>=20
> I see nothing in that file that defines any MSIs. I see code that looks
> like it maps ROOT COMPLEX MODE interrupts on regular PCI interfaces, whic=
h
> IS NOT WHAT I AM DOING.
>=20
> Since it seems I have been unclear, let me state this as clearly as possi=
ble.
>=20
> I AM DOING ENDPOINT MODE.

Shouting is not going to make you any friends.

cheers



--=-h9A/RH7kG4HH33R5GLTK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAky1BvQACgkQdSjSd0sB4dKAkACfYSqXas1bTBGUu4mHLyelNGuM
vq0AnRIrnDRJY9wmNee2owjv3QLqMynx
=bG58
-----END PGP SIGNATURE-----

--=-h9A/RH7kG4HH33R5GLTK--
