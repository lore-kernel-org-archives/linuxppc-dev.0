Date: Sun, 23 Sep 2001 22:18:39 -0800
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: More problems with Kernel 2.4.10-pre12 and mounting
Message-ID: <20010923221839.G14835@plato.local.lan>
References: <20010923191713.E14835@plato.local.lan> <Pine.LNX.4.21.0109232320480.13300-100000@cr242184-a.etob1.on.wave.home.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G1IH56i3DES2a+WZ"
In-Reply-To: <Pine.LNX.4.21.0109232320480.13300-100000@cr242184-a.etob1.on.wave.home.com>; from tendim@tendim.cjb.net on Mon, Sep 24, 2001 at 12:22:22AM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--G1IH56i3DES2a+WZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2001 at 12:22:22AM -0400, patrick wrote:
>=20
> On Sun, 23 Sep 2001, Ethan Benson wrote:
>=20
> > the dd trick shows you can read the device without problems, are you
> > sure the filesystem is not corrupt? or that the disk is not failing?
>=20
> But the problem isn't limited to /dev/sdb, since /dev/sda also has
> problems.  (I can't do any of the tricks, i.e., dd or pdisk -l /dev/sda
> with it either.  Again, this is all under 2.4.10-pre12, 2.2.18 works
> fine.)

well sounds to me like your scsi driver is hosed then. =20
=20
> > badblocks -sv /dev/sdb
>=20
> Nothing bad happened, and no error messages came out (I checked
> the entire /dev/sdb drive), so I'm assuming my drive is ok.

well if badblocks has no problem reading the entire device why should
anything else.  this clearly has nothing to do with partition table
support.

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--G1IH56i3DES2a+WZ
Content-Type: application/pgp-signature
Content-Disposition: inline


--G1IH56i3DES2a+WZ--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
