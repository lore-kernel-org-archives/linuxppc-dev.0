Date: Thu, 26 Apr 2001 14:12:18 -0800
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: 9.1 Gbyte SCSI Drive
Message-ID: <20010426141218.B16008@plato.local.lan>
References: <200104260559.HAA00741@piglet.grunz.lu> <Pine.LNX.4.21L.0104261458530.1089-100000@naproxen.weh.andrew.cmu.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
In-Reply-To: <Pine.LNX.4.21L.0104261458530.1089-100000@naproxen.weh.andrew.cmu.edu>; from hollis+@andrew.cmu.edu on Thu, Apr 26, 2001 at 03:00:44PM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 26, 2001 at 03:00:44PM -0400, Hollis R Blanchard wrote:
>=20
> As long as you don't try to make it with pdisk, which claims all disks
> without an existing valid Apple partition map are 512.0 GB.

there is a workaround for that, just tell it how many blocks the disk
has, this is discussed in my mac-fdisk-basics doc at
http://www.alaska.net/~erbenson/doc and
http://penguinppc.org/usr/ybin/doc/

> parted (or Drive Setup) should work fine.

parted is fine. Drive setup is evil. =20

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature
Content-Disposition: inline


--OwLcNYc0lM97+oe1--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
