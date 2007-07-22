Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 67541DDEF2
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Jul 2007 11:54:53 +1000 (EST)
Date: Sun, 22 Jul 2007 11:55:03 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Don't compile the PMU power driver on 64-bit PowerPC
Message-Id: <20070722115503.909f746f.sfr@canb.auug.org.au>
In-Reply-To: <18082.43262.487474.356610@cargo.ozlabs.ibm.com>
References: <18082.43262.487474.356610@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sun__22_Jul_2007_11_55_03_+1000_L1hXU0TRBC_BKsDi"
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sun__22_Jul_2007_11_55_03_+1000_L1hXU0TRBC_BKsDi
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 22 Jul 2007 10:46:54 +1000 Paul Mackerras <paulus@samba.org> wrote:
>
> As reported by Stephen Rothwell, an allmodconfig build on 64-bit
> PowerPC reports these errors:
>=20
> ERROR: "pmu_batteries" [drivers/power/pmu_battery.ko] undefined!
> ERROR: "pmu_battery_count" [drivers/power/pmu_battery.ko] undefined!
> ERROR: "pmu_power_flags" [drivers/power/pmu_battery.ko] undefined!
>=20
> This fixes the problem by not building pmu_battery.ko on ppc64.  There
> are no battery-powered ppc64 machines with an Apple PMU, and we can be
> reasonably confident there never will be.
>=20
> Signed-off-by: Paul Mackerras <paulus@samba.org>

That fixes it.
Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>
for what its worth :-)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__22_Jul_2007_11_55_03_+1000_L1hXU0TRBC_BKsDi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGorj7TgG2atn1QN8RAmBbAJ4nmQDXKBol1jyT1eY+8aP/Lczb5gCfVE90
Us5gX044vOpEspkIOw6+68s=
=25zN
-----END PGP SIGNATURE-----

--Signature=_Sun__22_Jul_2007_11_55_03_+1000_L1hXU0TRBC_BKsDi--
