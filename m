Date: Fri, 10 Nov 2000 16:00:46 -0900
From: Ethan Benson <erbenson@alaska.net>
To: jcarr@mail.linuxppc.org
Cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Example miboot on new world rom problem
Message-ID: <20001110160046.N4577@plato.local.lan>
References: <20001109172843.G4577@plato.local.lan> <Pine.LNX.4.21.0011101549510.3138-100000@jcarr.linuxppc.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Thv7PGoFpDPJ7Oar"
In-Reply-To: <Pine.LNX.4.21.0011101549510.3138-100000@jcarr.linuxppc.org>; from jcarr@mail.linuxppc.org on Fri, Nov 10, 2000 at 04:53:32PM -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--Thv7PGoFpDPJ7Oar
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable


On Fri, Nov 10, 2000 at 04:53:32PM -0600, jcarr@mail.linuxppc.org wrote:
> > setup a 800K Apple_Bootstrap partition where the newworld bootstrap is
> > installed, that will solve your problem.  if you put it first you
> > don't need to do anything to OpenFirmwares configuration, just reset
> > it to defaults. =20
>=20
> Ok. That sounds workable. Is that what OSX does also? If so, will it
> conflict?

when OSX is installed on an OldWorld or with UFS filesystems it
creates two bootstrap partitions, the first being Apple_Boot the
second being Apple_Secondary or something close to that.  since i have
been using Apple_Bootstrap OSX appears to ignore ours.  (the installer
does sometimes reorder all the partitions around to put its own first,
which is annoying since it hoses /etc/fstab among other things.  its
fixable with mac-fdisk though i added explanation on how to my
mac-fdisk doc)

> > miboot needs alot of things...  simplest way to deal with this is
> > don't install miboot on a newworld!  we don't install lilo on sparcs
> > or silo on x86 boxes afterall. =20
>=20
> Well, I think that the macos will not like the system folder unless it has
> a system file. But whatever we put in the system folder as the system

the MacOS does not like fake system folders of any kind, even these
fake ones you create are being deblessed and thus made unbootable by
MacOS very regularly.  i have a large mailbox of users asking me what
to do about this, i always tell them to change the partition type of
thier bootstrap partition to Apple_Bootstrap so MacOS can't see it
anymore.  that is the only solution that works 100% =20

> file, we will still have the problem we were having:
>=20
> Anyone that has a partition visable to the macos and trys to boot off of
> it will still get miboot. And, I think, It will be hard to get people not
> to expect that to work.
> Jeff

thats why you don't install miboot on a newworld ;-)

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--Thv7PGoFpDPJ7Oar
Content-Type: application/pgp-signature


--Thv7PGoFpDPJ7Oar--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
