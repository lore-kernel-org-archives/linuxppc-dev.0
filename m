Return-Path: <sfr@canb.auug.org.au>
Date: Tue, 8 Jul 2008 12:40:38 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Josh Boyer <jwboyer@gmail.com>
Subject: Re: [Cbe-oss-dev] [patch 05/11] powerpc/cell: add spu aware cpufreq
	governor
Message-Id: <20080708124038.cedae8f2.sfr@canb.auug.org.au>
In-Reply-To: <1215465477.20774.65.camel@weaponx>
References: <20080704190535.316377278@arndb.de>
	<200807071659.23476.arnd@arndb.de>
	<1215444942.20774.50.camel@weaponx>
	<200807072315.13666.arnd@arndb.de>
	<1215465477.20774.65.camel@weaponx>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__8_Jul_2008_12_40_38_+1000_o2S67Rz82cjpXdIp"
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__8_Jul_2008_12_40_38_+1000_o2S67Rz82cjpXdIp
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 07 Jul 2008 17:17:57 -0400 Josh Boyer <jwboyer@gmail.com> wrote:
>
> On Mon, 2008-07-07 at 23:15 +0200, Arnd Bergmann wrote:
> > On Monday 07 July 2008, Josh Boyer wrote:
> > >=20
> > > On Mon, 2008-07-07 at 16:59 +0200, Arnd Bergmann wrote:
> > > > On Monday 07 July 2008, Stephen Rothwell wrote:
> > > > > > +#define POLL_TIME    100000          /* in us */
> > > > >                                               ^
> > > > > How about =CE=BC ?
> > > >=20
> > > > Not sure, how about =C2=B5 instead? ;-)
> > >=20
> > > Erm... don't get it.  You have identical characters here.
> >=20
> > That depends on the tool you use to look at it.
> >=20
> > Stephen wrote a Unicode character U+03BC from the Greek alphabet part of
> > unicode, I wrote unicode character U+00B5 from the Latin-1 code page.
> > In my mail client, latin-1 characters get rendered in the default font,
> > but it has to change the font for less common scripts.
>=20
> I thought Unicode was supposed to _improve_ stuff like that... ;)

In fact, Arnd was right, I used the Greek letter mu (=CE=BC) while he chose=
 the
micro sign (=C2=B5).  So, the lartter (Unicode 0x00B5) it should be.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__8_Jul_2008_12_40_38_+1000_o2S67Rz82cjpXdIp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhy06YACgkQjjKRsyhoI8xPmACggIGUXvXnx3YcVCzMjq9jYyhy
mCsAn0ney94gGAZfk8+df0saPpZt5PF1
=b+IL
-----END PGP SIGNATURE-----

--Signature=_Tue__8_Jul_2008_12_40_38_+1000_o2S67Rz82cjpXdIp--
