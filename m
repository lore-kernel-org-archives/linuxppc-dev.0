Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 33A6ADDF0E
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 13:17:46 +1100 (EST)
Date: Thu, 10 Jan 2008 13:17:34 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 2/3] [libata] pata_of_platform: OF-Platform PATA device
	driver
Message-Id: <20080110131734.b267187c.sfr@canb.auug.org.au>
In-Reply-To: <20080110003634.GA19966@lixom.net>
References: <20080109190852.GA18827@localhost.localdomain>
	<20080109191041.GB23283@localhost.localdomain>
	<20080110104048.2fea6ab3.sfr@canb.auug.org.au>
	<20080110003634.GA19966@lixom.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__10_Jan_2008_13_17_34_+1100_rzlQLkdYc=Rx1oLu"
Cc: Paul Mundt <lethal@linux-sh.org>, linuxppc-dev@ozlabs.org,
	Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__10_Jan_2008_13_17_34_+1100_rzlQLkdYc=Rx1oLu
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 9 Jan 2008 18:36:34 -0600 Olof Johansson <olof@lixom.net> wrote:
>
> On Thu, Jan 10, 2008 at 10:40:48AM +1100, Stephen Rothwell wrote:
> > Hi Anton,
> >=20
> > Juts one small trivial comment (could be fixed later).
> >=20
> > On Wed, 9 Jan 2008 22:10:41 +0300 Anton Vorontsov <avorontsov@ru.mvista=
.com> wrote:
> > >
> > > +static struct of_device_id pata_of_platform_match[] =3D {
> >=20
> > This could be declared const.
>=20
> Good point, but let's not hold up merge based on this. Need something
> for janitors to do too, and it's good enough to merge as-is. :)

Absolutely. To me that is what "(could be fixed later)" means.  :-)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__10_Jan_2008_13_17_34_+1100_rzlQLkdYc=Rx1oLu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHhYBCTgG2atn1QN8RAgl7AJwP44WTJurK/asFDwyjLuopzrtJnACggcEU
QNGKykytLKYldJKxF/nSe4Y=
=+vOv
-----END PGP SIGNATURE-----

--Signature=_Thu__10_Jan_2008_13_17_34_+1100_rzlQLkdYc=Rx1oLu--
