Date: Wed, 24 May 2000 16:18:37 +0200
From: Bernhard Reiter <bernhard@intevation.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Powerbook hard freeze summary (sort of)
Message-ID: <20000524161837.M6396@cheops.usf.Uni-Osnabrueck.DE>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vJI8q/aziP9idhqk"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--vJI8q/aziP9idhqk
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Okay, we have a couple of people running stable Lombards with
more than 64 MB.

On the other hand, we have people having hard freezes with
Lombard and Pismos even with 64 MB.

So my analysis is as follows:=20

High bus speed (400 Mhz) seems to be necessary to trigger this hard
freeze.=20
More memory makes it more likely for hard freezes to appear.

If there is a problem with the memory it is more likely that it is with the=
=20
original 64 MB.


Is there somebody out there having a >=3D400 Mhz Lombard
and Pismo who is _not encountering hard freezes_ under high pressure?
(Preferably with more that 64MB. Because I never got the hard freeze
when I only used 64MB with the mem=3D64MB switch.)

It might as well be a design problem of the Powerbooks. Can any of the=20
hardware kernel hackers comments on the differences in architecture
for powerbooks and the other G3s? Maybe a linux driver is written sloppy
in this area not taking in account how the hardware actually works?

	Bernhard

ps.: Just I reminder: I am not subscribed ot the list.

--vJI8q/aziP9idhqk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (SunOS)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjkr5LwACgkQh9ag3dpKERZBjgCeKImiuil8t5MN0PP5FUWeWorL
20gAoKP/rqkNEhAHgzHl+zU9Ipqga+7W
=XFzH
-----END PGP SIGNATURE-----

--vJI8q/aziP9idhqk--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
