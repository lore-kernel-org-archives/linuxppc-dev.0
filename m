Date: Thu, 13 Jul 2000 14:22:02 -0400
From: Josh Huber <huber@mclinux.com>
To: Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: > 512 MB of ram on G4?
Message-ID: <20000713142202.A1289@mclx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey, I'm trying to put 1GB of ram in an Apple G4 box here, but I'm having
trouble.  Anything higher (well, in increments of 256M) is dumping me into
xmon early on boot (before the fbcons is initialized).

Any thoughts?  I'm unable to use xmon because of the USB
keyboard...unfortunately.  Too bad Apple didn't put a real serial port on
these machines :(

Thanks,
--=20
Josh
6B21489A | GnuPG ID/Fingerprint | huber@mclx.com |
61F0 6138 BE7B FEBF A223  E9D1 BFE1 2065 6B21 489A

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature
Content-Disposition: inline


--RnlQjJ0d97Da+TV1--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
