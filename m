Date: Sat, 20 May 2000 00:29:47 -0800
From: Ethan Benson <erbenson@alaska.net>
To: Debian-PowerPC <debian-powerpc@lists.debian.org>,
        Linux/PPC-devel <linuxppc-dev@lists.linuxppc.org>
Subject: Paul's 2.2.15 does not boot a 7200
Message-ID: <20000520002947.A6452@plato.local.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Hi,

I have rsynced paul's stable kernel tree to 2.2.15 proper (no pre),
this kernel works quite well with a G3 via yaboot, but will not boot a
7200 (via quik).  I have tried my own custom config as well as Paul's
config included in the rsync tree.  quik loads the kernel successfully
and prints `Copying Device tree' just like it does for 2.2.14 but the
monitor just stays black and nothing else happens, it never boots any
further.=20

the quik used is the current debian quik sources, patched by Dan
Jacobowitz to support powermacs. (there is no macos on this machine so
bootx is not an option, nor testable)

has anyone else had problems with 2.2.15 on 7200s?=20

the system runs Debian potato, and runs paul's 2.2.14.=20

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjkmTPsACgkQJKx7GixEevymzACfR9ewxmca7iQ8LjfY58b2umTB
dEwAn33KOHJjT5SdaL3DZopxJ/FOwPQg
=72fp
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
