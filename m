Date: Wed, 10 May 2000 19:28:13 +0200
From: Bernhard Reiter <bernhard@intevation.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Lombard hard freeze (update: mem>64MB)
Message-ID: <20000510192813.B2162@cheops.usf.Uni-Osnabrueck.DE>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Got one step forward with the hard freeze problem.

My local Apple shop (ProDatenTechnik in Osnabr=FCck),
was to kind to let me check through a new memory module.

When I had only 64MB the system was stable!
I managed to compile GRASS (which is among the biggest free software
projects) and other things.

Plugging in a different 128MB and a different 64MB, both in the first
slot, made the system unstable each time.

This explains why Micheal has a stable system.
Sadly it is still a big problem.

To answer some of the suggestions:
The problem is there, even when I never start X11 and work
from the virtual console. There is absolutly no output.
No ethernet network ping, no memory monitor, no kernel panic, nothing.=20
The cursor stops blinking (and everything else moving) and it is over.

As about the power consumption and the heat: It is my understanding that
the fan should start up when there is too much heat controlled by
hardware. But the fan does not start. And freezes also occur when the=20
machine itself it cold. I also do not quite understand how the power
consumption could be a problem here.=20

It would so nice to have a person who can debug it.
I will test two things:=20
	Setting mem=3D64M and see if it makes it stable.

	Maybe a development line kernel has some fixes for this stuff,=20
	I shall try one.=20

Maybe we should ask for Lombard users which have a stable system=20
with more as 64MB memory. Can they do huge compiles?
Somebody should have a lombard the symptom and the guts to debug it.

	Bernhard
ps.: Please remember that I am not on the dev list.

--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (SunOS)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjkZnCwACgkQh9ag3dpKERZGDgCfb7h+Ssk1nea5WcvSvt99UFDd
gA8An2VgbPo6VUAuEARtBaYweecizY4a
=rE2q
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
