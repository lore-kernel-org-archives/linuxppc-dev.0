Date: Sun, 23 Sep 2001 15:46:07 -0800
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: More problems with Kernel 2.4.10-pre12 and mounting
Message-ID: <20010923154607.A14835@plato.local.lan>
References: <20010922234424.X14835@plato.local.lan> <Pine.LNX.4.21.0109231331340.11517-100000@cr242184-a.etob1.on.wave.home.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jE+K4o1MICf3EEet"
In-Reply-To: <Pine.LNX.4.21.0109231331340.11517-100000@cr242184-a.etob1.on.wave.home.com>; from tendim@tendim.cjb.net on Sun, Sep 23, 2001 at 01:33:54PM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--jE+K4o1MICf3EEet
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 23, 2001 at 01:33:54PM -0400, patrick wrote:
> On Sat, 22 Sep 2001, Ethan Benson wrote:
>=20
> > what happens if you run the following:
> >=20
> > dd if=3D/dev/sdb of=3D/dev/null bs=3D512 count=3D1
> >=20
> > i am betting you will get a `No such device' error which means the
> > kernel thinks there is no second scsi device.
>=20
> Nope, I get:
>=20
> 1+0 records in
> 1+0 records out
>=20
> Related, my partition map for /dev/sdb is:
>=20
> Partition   Dec
> 0           Apple driver
> 1           ??
> 2           ??
> 3           HFS
> 4           e2fs
>=20
> I can mount /dev/sdb4.
>=20
> This all points to a problem with Apple Partition Support..?

is it possible you have an x86 BIOS partition table on that disk as
well?  if mac-fdisk -l doesn't work then your mac partition table is
corrupt.  but if that does work but the kernel is getting other ideas
about your partitions you probably have both an x86 and mac partition
table (its actually possible for them to coexist, but its a gross and
uneeded hack).  what does /proc/partitions say?

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--jE+K4o1MICf3EEet
Content-Type: application/pgp-signature
Content-Disposition: inline


--jE+K4o1MICf3EEet--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
