Date: Sun, 23 Apr 2000 23:52:43 -0800
From: Ethan Benson <erbenson@alaska.net>
To: "W. Taylor Holliday" <wtholliday@ucdavis.edu>
Cc: LinuxPPC dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Trouble w/yaboot
Message-ID: <20000423235243.L16721@plato.localdomain.local>
References: <200004240637.XAA05529@pop3.ucdavis.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fDERRRNgB4on1jOB"
In-Reply-To: <200004240637.XAA05529@pop3.ucdavis.edu>; from wtholliday@ucdavis.edu on Sun, Apr 23, 2000 at 11:37:33PM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--fDERRRNgB4on1jOB
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 23, 2000 at 11:37:33PM -0700, W. Taylor Holliday wrote:
>=20
> hi again :-)
>=20
> I have an AGP G4 and I'm having trouble getting yaboot to work (I realize
> this is nothing new). I've tried various OF device aliases and none will
> work except cd: (using the linuxPPC installer CD). Both hd: and ultra0: do
> not work (I'm using the partition number w/the kernel on it - doubt there=
's
> any mistake there); yaboot says the device could not be found. I've even
> tried using the zip: alias and a zip disk with my kernel on it to no avai=
l.
> Any suggestions?

exactly what command are you using to boot yaboot? are you using the
internel IDE disk?  scsi disks do not have device aliases (at least
not that i have seen)

is it OpenFirmare or yaboot that is claiming device not found?
(yaboot turns the screen black)=20

the hd: alias SHOULD work

boot hd:6,yaboot  if partition 6 is the one with yaboot on it...

as for your previous message it seems you figured out the answer
yourself: don't use BootX, use yaboot ;-)

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--fDERRRNgB4on1jOB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjkD/UsACgkQJKx7GixEevw4dgCdHXKNQLae0AHz2KNy0LAbAz/N
jCUAn3phZPCfCTyKIVFl6z1RKn9zISFR
=c58H
-----END PGP SIGNATURE-----

--fDERRRNgB4on1jOB--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
