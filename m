Date: Fri, 7 Jul 2000 21:07:26 -0800
From: Ethan Benson <erbenson@alaska.net>
To: Michel Lanners <mlan@cpu.lu>
Cc: linuxppc-dev@lists.linuxppc.org, clausen@gnu.org, parted@gnu.org
Subject: Re: GNU Parted, linuxppc support coming :-)
Message-ID: <20000707210726.C7162@plato.local.lan>
References: <20000705130158.A18557@drow.them.org> <200007060537.HAA01020@piglet.grunz.lu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mJozIRmlDRkE95ph"
In-Reply-To: <200007060537.HAA01020@piglet.grunz.lu>; from mlan@cpu.lu on Thu, Jul 06, 2000 at 07:37:34AM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--mJozIRmlDRkE95ph
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 06, 2000 at 07:37:34AM +0200, Michel Lanners wrote:
>=20
> Hi all,
>=20
> >> Excuse my ignorance... what FS's do people usually use with MacOS?
> >> HFS/HFS+?
>=20
> Something  wanted to add to a previous mail in the thread:
>=20
> Don't forget that there are lots of Macs that _absolutely_ need at least
> one HFS partition and an Aple partition map on one of there disks,
> because that's the only thing the ROM can boot some OS from.
>=20
> AFAICT, all pre-NewWorld machines are in this case, except maybe some
> that can be tweaked to network boot...

oldworld macs this is true i think.  newworld macs CAN boot from a
disk with DOS partition tables, but you have to configure OpenFirmware
to non-standard settings.  with a small Apple_Bootstrap partition in
HFS format setup by ybin will boot with defaults.

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--mJozIRmlDRkE95ph
Content-Type: application/pgp-signature


--mJozIRmlDRkE95ph--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
