Date: Sat, 22 Apr 2000 12:37:47 +0200
From: Bernhard Reiter <bernhard@intevation.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Serial driver problem (modem Lombard)
Message-ID: <20000422123747.B8503@cheops.usf.Uni-Osnabrueck.DE>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

There is a difference in modem device behaviour
between 2.2.15pre3(coming with LinuxPPC2000) and 2.2.15pre19(after=20
Paul M's stable tree, build myself using his .config).

wvdail cannot open /dev/ttyS0 twice with 2.2.51pre19.
After I ctrl-ced wvdial to interrupt the network connection
I get an I/O error when I try to open it again.

Running wvdialconf it started scanning ttyS1 and
then jumped into the system monitor:

vector:200 at pc=3Dd0849344 msr=3D1030, sp=3Dc7bf3ce0 [c7bf3ce0]
current=3Dc7bf2000, pid 745 comm=3Dinsmod

Maybe that is an irport error and unrelated to the first problem.
I have not enquired further, though.

Regards,
	Bernhard
ps: Please carbon copy relevant replies to me.
--=20
Professional Service around Free Software                (intevation.net) =
=20
The FreeGIS Project				            (freegis.org)
Association for a Free Informational Infrastructure            (ffii.org)

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (SunOS)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjkBgPoACgkQh9ag3dpKERahBQCgqQHw4Gl6SIAi5E05JrNbrW2l
hRkAn1ozCcWWakj34/ZrvXfWPNIuMo4D
=dMPj
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
