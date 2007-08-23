Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 79009DDF48
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 15:59:56 +1000 (EST)
Date: Thu, 23 Aug 2007 15:59:48 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: bogus vscsi dt node on iseries
Message-Id: <20070823155948.6d802da0.sfr@canb.auug.org.au>
In-Reply-To: <20070823054239.GA24251@aepfle.de>
References: <20070822175121.GA21233@aepfle.de>
	<20070823133621.830245c4.sfr@canb.auug.org.au>
	<20070823054239.GA24251@aepfle.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__23_Aug_2007_15_59_48_+1000_/.nw_j8x/JP8Yzk0"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__23_Aug_2007_15_59_48_+1000_/.nw_j8x/JP8Yzk0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Aug 2007 07:42:39 +0200 Olaf Hering <olaf@aepfle.de> wrote:
>
> On Thu, Aug 23, Stephen Rothwell wrote:
>=20
> > On Wed, 22 Aug 2007 19:51:21 +0200 Olaf Hering <olaf@aepfle.de> wrote:
> > >
> > >=20
> > > Does anyone know why dt_vdevices() creates a vscsi node on legacy ise=
ries?
> > > I'm sure only viodasd and viocd is required as blockdevice type.
> >=20
> > Because the IBM vscsi client (in theory) works on legacy iSeries.
>=20
> I'm asking because there are many unneeded nodes.
> Have you tried to create only the nodes for disks/cds that are really
> present and modify viodasd to use only device-tree data?

I'll have a look, but that would require interacting with the hypervisor
very early in the boot sequence ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__23_Aug_2007_15_59_48_+1000_/.nw_j8x/JP8Yzk0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGzSJYTgG2atn1QN8RAmw9AJ9TdhN/qR1Pv23Vl584O98Zla60tgCff84g
ahmBw/lj+Rtfe46Gpz3OyfQ=
=m/D3
-----END PGP SIGNATURE-----

--Signature=_Thu__23_Aug_2007_15_59_48_+1000_/.nw_j8x/JP8Yzk0--
