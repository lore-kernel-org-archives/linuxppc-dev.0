Date: Sat, 22 Sep 2001 23:44:24 -0800
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: More problems with Kernel 2.4.10-pre12 and mounting
Message-ID: <20010922234424.X14835@plato.local.lan>
References: <p05100300b7d31fabc70d@[10.0.0.42]> <Pine.LNX.4.21.0109230313420.1883-100000@cr242184-a.etob1.on.wave.home.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="72btQdUC6twB1rwh"
In-Reply-To: <Pine.LNX.4.21.0109230313420.1883-100000@cr242184-a.etob1.on.wave.home.com>; from tendim@tendim.cjb.net on Sun, Sep 23, 2001 at 03:14:39AM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--72btQdUC6twB1rwh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 23, 2001 at 03:14:39AM -0400, patrick wrote:
>=20
> On Sat, 22 Sep 2001, Timothy A. Seufert wrote:
>=20
> > You could always give up and connect sdb to your 2940UW's internal
> > 50-pin connector instead of mesh.  (only half joking -- I'm under the
> > impression that the mesh driver is not well maintained these days.)
>=20
> I wish it were that easy.
>=20
> I've just noticed that it not only MESH, but the Adaptec card as
> well.  Which means the problem isn't limited to the driver (MESH or
> Adaptec), and it isn't my own hardware (again, 2.2.x works fine).
>=20
> Me thinks it is something to do with the Apple partition map support in
> general.

what happens if you run the following:

dd if=3D/dev/sdb of=3D/dev/null bs=3D512 count=3D1

i am betting you will get a `No such device' error which means the
kernel thinks there is no second scsi device.

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--72btQdUC6twB1rwh
Content-Type: application/pgp-signature
Content-Disposition: inline


--72btQdUC6twB1rwh--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
