Date: Thu, 9 Nov 2000 17:28:43 -0900
From: Ethan Benson <erbenson@alaska.net>
To: jcarr@mail.linuxppc.org
Cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Example miboot on new world rom problem
Message-ID: <20001109172843.G4577@plato.local.lan>
References: <19341004092456.12247@192.168.1.2> <Pine.LNX.4.21.0011091043510.1824-100000@jcarr.linuxppc.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hcut4fGOf7Kh6EdG"
In-Reply-To: <Pine.LNX.4.21.0011091043510.1824-100000@jcarr.linuxppc.org>; from jcarr@mail.linuxppc.org on Thu, Nov 09, 2000 at 11:12:09AM -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--hcut4fGOf7Kh6EdG
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 09, 2000 at 11:12:09AM -0600, jcarr@mail.linuxppc.org wrote:

> Yes I need to look at the ybin script again. However, this doesn't fix the
> problem of miBoot running on New World ROM machines and also does not
> provide a solution to the problem either. The problem that the guy was
> having with his ibook and I have with the iMac DV. The only way that this
> guy is left to boot yaboot is to go into OF and do:

setup a 800K Apple_Bootstrap partition where the newworld bootstrap is
installed, that will solve your problem.  if you put it first you
don't need to do anything to OpenFirmwares configuration, just reset
it to defaults. =20

> boot hd:9,\\:tbxi
>=20
> The functionality of SetPRAMBoot(by that I mean the ability to do what
> startup disk does) needs to be added to yaboot not for the reasons I

huh?  i don't see why.  recent ybin creates a nice boot menu that
takes care of loading macos just fine without any of this StartupDisk garba=
ge.

> stated earlier. So I was wrong about the reasons I stated in the last
> email. Sorry about that... this all can be rather convoluted! This
> functionality needs to be there if yaboot is to ever allow users to select
> thier MacOS boot partitions.

making yaboot load macos would be non-trivial.  however with current
ybin versions you can add `macos=3D/dev/hda10' to /etc/yaboot.conf and
ybin will build a menu that is displayed on bootup.  works very
nicely. =20

> In the other case, miBoot needs to have the ability to change the
> boot-device if it detects that it is running on a New World ROM
> machine. Maybe Harry Eaton or Mike Tesch are still around and can help
> grok bootvars code to add to miboot?

miboot needs alot of things...  simplest way to deal with this is
don't install miboot on a newworld!  we don't install lilo on sparcs
or silo on x86 boxes afterall. =20

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--hcut4fGOf7Kh6EdG
Content-Type: application/pgp-signature


--hcut4fGOf7Kh6EdG--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
