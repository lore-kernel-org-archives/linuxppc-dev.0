Date: Tue, 25 Apr 2000 01:08:26 -0800
From: Ethan Benson <erbenson@alaska.net>
To: Daniel Gonzalez <daniel.gonzalez@pandora.be>
Cc: LinuxPPC Dev List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Bye HFS partition?
Message-ID: <20000425010826.T7022@plato.localdomain.local>
References: <390516C2.1DD0D2D@pandora.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QCC2I/2CckNfI+Tr"
In-Reply-To: <390516C2.1DD0D2D@pandora.be>; from daniel.gonzalez@pandora.be on Mon, Apr 24, 2000 at 11:53:38PM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--QCC2I/2CckNfI+Tr
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 24, 2000 at 11:53:38PM -0400, Daniel Gonzalez wrote:
>=20
> Hi,
>=20
> I have just destroyed my hfs partition (I was trying to make
> a directory there and ... oooops!)

do you mean you ran into the general unreliablity of the kernel's HFS
support?

> What resources do I have to analyze and recover my data ?

sadly there are no utilities for linux that will do any kind of
recovery on HFS filesystems, the MacOS side has Disk First Aid which
is fairly limited and gives up easily, but its free (beer) and worth a
try, beware though that it could make things worse, Norton Utilities
4 worked very well at recovering data from HFS filesystems but is
expensive and no longer available, only buggy version 5 exists now. =20


--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--QCC2I/2CckNfI+Tr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjkFYIoACgkQJKx7GixEevxedwCgjkir+lkD7632yzeEgASr9a4c
HKoAoI1qk7FODITsM5MXPGdWt6Pi0psN
=xCrd
-----END PGP SIGNATURE-----

--QCC2I/2CckNfI+Tr--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
