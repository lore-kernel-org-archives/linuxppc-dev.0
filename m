Date: Sat, 22 Apr 2000 12:31:07 +0200
From: Bernhard Reiter <bernhard@intevation.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Lombard hard freeze
Message-ID: <20000422123107.A8503@cheops.usf.Uni-Osnabrueck.DE>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Hello Linuxppc developers,

I encounter hard freezes with my lombard G3/400 Powerbook.
Though I cannot completely rule out hardware problems, it might
be the software. The system never stopped running in MacOS 8.6
I tried the TechTool Deluxe tests and the Gauge Pro Ram Check
under MacOS without revealing any problems.

The freezes occurr randomly when heavy compiling is done.
(Like I cannot compile gnomehack 1.0.5 three times, it usually
happens in the second compile attempt.) If you want to try
ftp://intevation.de/users/bernhard has the .src.rpm right now.

It does not matter if it is cold or warm, X11 running or pmud running.
I tested Kernel versions 2.2.14 2.2.15-pre3 2.2.15-pre19
together with the LinuxPPC 2000 install and the upgraded LinuxPPC 1999
install (on two different partitions).
I upgraded glibc, binutils and gcc.

This powerbook has a 10 GB harddisc and 192 Mb ram, so it does not even
swap for this compile.

Another little detail hints towards a software problem:
Even if I give the computer breaks after, let's say the first
gnomehack compile, it chances to run through the next one is not higher.
It looks like disorder somewhere in the kernel piles up, still it is
a matter of time to lock up the machine.

I would be glad if someone could help me to track the problem
down further. I was told that this is the right place to ask.

Regards,
	Bernhard
ps.: Please carbon copy relevant replies to me.

--=20
Professional Service around Free Software                (intevation.net) =
=20
The FreeGIS Project				            (freegis.org)
Association for a Free Informational Infrastructure            (ffii.org)

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (SunOS)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjkBf2oACgkQh9ag3dpKERb3IgCfXrw5TwqGkHhtGZ06C+nZVIk3
f5YAoM1fJbbPHOI+iLBHZ5SQpU7ZUdSh
=5ZhE
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
