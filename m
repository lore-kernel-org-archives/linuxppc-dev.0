Date: Wed, 10 May 2000 19:55:13 +0200
From: Bernhard Reiter <bernhard@intevation.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Lombard hard freeze (update: mem>64MB)
Message-ID: <20000510195513.B2892@cheops.usf.Uni-Osnabrueck.DE>
References: <20000510192813.B2162@cheops.usf.Uni-Osnabrueck.DE> <Pine.LNX.3.96.1000510104735.21621B-100000@deepspace.mklinux.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7qSK/uQB79J36Y4o"
In-Reply-To: <Pine.LNX.3.96.1000510104735.21621B-100000@deepspace.mklinux.org>; from dgatwood@deepspace.mklinux.org on Wed, May 10, 2000 at 10:53:52AM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--7qSK/uQB79J36Y4o
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Wed, May 10, 2000 at 10:53:52AM -0700, David A. Gatwood wrote:
> On Wed, 10 May 2000, Bernhard Reiter wrote:

> > When I had only 64MB the system was stable!
> > I managed to compile GRASS (which is among the biggest free software
> > projects) and other things.
> >=20
> > Plugging in a different 128MB and a different 64MB, both in the first
> > slot, made the system unstable each time.
>=20
> So it worked with your original 64 megs, but it fails with a different 64
> meg part and a 128 meg part? =20

It was stalbe with my original 64 megs.
Putting additional RAM in made it unstable.
The symptom occurred with three differnent addition RAM simms.
128,128,64 megs.

> I don't see how that can be anything but bad
> hardware, either something wrong with the motherboard or a pair of bad
> SIMM/DIMM parts or dirty contacts or incorrectly seated RAM.

The problem is that a simple RAM stress test under MacOS would certainly
reveal that. (If it is a simple hardware problem, like you suggested.)

But the RAM tests were passed in MacOS so far.
(I have another one running right now. It will take a bit.)

	Bernhard
--=20
Professional Service around Free Software                (intevation.net) =
=20
The FreeGIS Project				            (freegis.org)
Association for a Free Informational Infrastructure            (ffii.org)

--7qSK/uQB79J36Y4o
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (SunOS)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjkZon8ACgkQh9ag3dpKERYndQCg2KkaNAvff7dtQevB26WEmTgN
tuQAnjXB9tuJWEHXqVgwdsQxwnIdFtEJ
=puol
-----END PGP SIGNATURE-----

--7qSK/uQB79J36Y4o--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
