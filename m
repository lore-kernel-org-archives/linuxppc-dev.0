Date: Sun, 14 May 2000 00:41:41 -0800
From: Ethan Benson <erbenson@alaska.net>
To: Even André Fiskvik <even@lynweb.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Yaboot
Message-ID: <20000514004141.E12729@plato.local.lan>
References: <B5442CED.220%even@lynweb.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6Vw0j8UKbyX0bfpA"
In-Reply-To: <B5442CED.220%even@lynweb.net>; from even@lynweb.net on Sun, May 14, 2000 at 10:14:06AM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--6Vw0j8UKbyX0bfpA
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Sun, May 14, 2000 at 10:14:06AM +0200, Even Andr=E9 Fiskvik wrote:
>=20
> Could someone please tell me how to use yaboot to boot LinuxPPC 2000
> of my PowerBook Pismo ?
> I can't find any documentation on the Yaboot software, and when
> I copy the system folder on the LinuxPPC 2000 CD-ROM to my HFS Standard
> harddisk and tries to boot from it, the only thing coming up is a penguin
> instead of the mac os ROM face, and it just hangs there...
>=20
> I'm suspecting that it uses miBoot rather than the Yaboot....
> Could someone please help me out one this one?

see the yaboot-faq on
http://www.alaska.net/~erbenson/doc/yaboot-faq.html=20

also see the man pages included in the ybin (also on my page) package,
which is a GNU/Linux based installer utility for yaboot.

i recommend setting up a small 800K bootstrap partition as this makes
using yaboot much easier. =20

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--6Vw0j8UKbyX0bfpA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjkeZsUACgkQJKx7GixEevx+UQCfU+P9r4GPZOxPFzHHvv8lDPuC
zIYAoIwN30RUjiTluJXRbDXtXFkcKn4K
=+S7i
-----END PGP SIGNATURE-----

--6Vw0j8UKbyX0bfpA--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
