Date: Mon, 24 Sep 2001 15:04:37 -0800
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: More problems with Kernel 2.4.10-pre12 and mounting
Message-ID: <20010924150437.I14835@plato.local.lan>
References: <20010923221839.G14835@plato.local.lan> <Pine.NEB.4.33.0109241732420.19824-100000@vex.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v4FgCkd4vT7RadTR"
In-Reply-To: <Pine.NEB.4.33.0109241732420.19824-100000@vex.net>; from tendim@vex.net on Mon, Sep 24, 2001 at 05:39:59PM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--v4FgCkd4vT7RadTR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2001 at 05:39:59PM -0400, patrick wrote:
> On Sun, 23 Sep 2001, Ethan Benson wrote:
>=20
> > well sounds to me like your scsi driver is hosed then.
>=20
> Well if the SCSI driver is hosed, then shouldn't I *not* be able to do
> anything else then?  My setup is as follows:
>=20
> SCSI0 - Adaptec 2940 UW Card   /dev/sda
> SCSI1 - Mesh Internal SCSI     /dev/sdb
>=20
> And all of the drivers have been compiled into the kernel (no modules).
>=20
> > well if badblocks has no problem reading the entire device why should
> > anything else.  this clearly has nothing to do with partition table
> > support.
>=20
> Then that leaves it to the program I'm using to read the partition map.
> I've seen you reference "mac-fdisk".  Is this the same as pdisk?  Or
> is an entirely different beast?

its a debian modified version of pdisk thats more reliable.  get the
one from debian woody.

> Perhaps it is pdisk that doesn't like the new kernel.

i don't really see how.. its not doing much more then reading the
first 32k of of the disk to parse the partition table.

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--v4FgCkd4vT7RadTR
Content-Type: application/pgp-signature
Content-Disposition: inline


--v4FgCkd4vT7RadTR--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
