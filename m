Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 164A5DDDE7
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 01:58:52 +1100 (EST)
Subject: Re: powerpc allmodconfig
From: Johannes Berg <johannes@sipsolutions.net>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20081015.220247.262683261.davem@davemloft.net>
	(sfid-20081016_070321_484206_CF986FB8)
References: <20081015213337.a99a9595.akpm@linux-foundation.org>
	<20081015.220247.262683261.davem@davemloft.net>
	(sfid-20081016_070321_484206_CF986FB8)
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-RwDHazsTlsfHEjp3GDNS"
Date: Thu, 16 Oct 2008 16:57:19 +0200
Message-Id: <1224169039.735.57.camel@johannes.berg>
Mime-Version: 1.0
Cc: bzolnier@gmail.com, marek.vasut@gmail.com, tiwai@suse.de,
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, ralf@linux-mips.org,
	mark.fasheh@oracle.com, linuxppc-dev@ozlabs.org,
	linux-ide@vger.kernel.org, akpm@linux-foundation.org,
	linux-ext4@vger.kernel.org, dwmw2@infradead.org,
	dan.j.williams@intel.com, mchehab@infradead.org,
	Arjan van de Ven <arjan@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-RwDHazsTlsfHEjp3GDNS
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2008-10-15 at 22:02 -0700, David Miller wrote:
>=20
>=20
> > net/sched/sch_generic.c: In function 'dev_watchdog':
> > net/sched/sch_generic.c:224: warning: unused variable 'drivername'
>=20
> Sucky, if WARN_ONCE() evaluates to nothing the sprintf() string buffer
> on the stack looks unused.

I've complained about this to Arjan before, we actually lose all
messages passed to WARN() or WARN_ONCE() on platforms that use bug traps
for warnings too.

johannes

--=-RwDHazsTlsfHEjp3GDNS
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJI91ZLAAoJEKVg1VMiehFYYlcQAIVtjS9xcVR3ZmM6893/7UIV
2XEXfwlKMLunk5fBVAPz2DF2x83tlyNHrALOW1zTWjM2teLzKCq0XtFsXIoMrUX5
0AuQBKmN/nf2+93YbfBH73zWmeegBz0yO1IaCdnjDT5P0Orn6mj4h7OBnb1u2Dxo
pNK/wOiX/v/2MKrfQnEBo9LHqMmlGonbvFPxBIVOeONzsjlv5BVMWqPhfxf9D7wI
m1GIDO13dYZ/ZkKuC5SchD+UJhFhPZd2pG1rxK8eRctDJXHa1dFEcVLrQq9zshBL
7xJ5n4jdw1M5PVKNB4Frd3H1nv8PGNKoNliodaNwj/ZC5ULxZXnFxECkPl3VGU63
5cUVGYTsqHUewPT7TigoYTD45AU85LWyhYHtN63hqbkeNH5Sf2QgN5XwQ7Wb3Urm
gk3MMi01RcUvuV0MtiWsqZ/Cu1HM6S4QsgxypZ7gtv867LiB17c3ucVbswPVRGgZ
A036WQSNA+gAQU3tV5J5D9eq8lphlmioLfUq4/mPKSn+UgI22iYMTPk9hMY/3dkZ
Iox3vd7GfiDiPmNoHaF27w9dlQURjU3ue0eC5G5gUvImzawU3l6bmVEHoNhT/DUJ
Q+2NSFvtZhYzFm1TUnHpyF0KYnAz6pogNY8155qCZ5dX7Wlc2wgpUkZJpdhc8iv9
nb5xAVWpNharfmm23n+R
=pg7B
-----END PGP SIGNATURE-----

--=-RwDHazsTlsfHEjp3GDNS--
