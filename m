Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 163AEDDD0B
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Jul 2007 00:12:06 +1000 (EST)
Received: from localhost (ta-1-1.tip.net.au [203.11.71.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id E744B368004
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Jul 2007 00:12:05 +1000 (EST)
Date: Sun, 22 Jul 2007 00:12:12 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: Someone broke my allmodconfig build
Message-Id: <20070722001212.5007001d.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sun__22_Jul_2007_00_12_12_+1000__9sDOHC4XfljpW+y"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sun__22_Jul_2007_00_12_12_+1000__9sDOHC4XfljpW+y
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

At the end of a powerpc allmodconfig build, I get this (after the header
checks):

  LD      vmlinux
  SYSMAP  System.map
  SYSMAP  .tmp_System.map
strip -s -R .comment vmlinux -o vmlinux.strip
strip -s -R .comment vmlinux -o arch/powerpc/boot/zImage.iseries
  WRAP    arch/powerpc/boot/zImage.pseries
  WRAP    arch/powerpc/boot/zImage.pmac
  WRAP    arch/powerpc/boot/zImage.ps3
/home/sfr/kernels/linus/arch/powerpc/boot/wrapper: line 113: dtc: command n=
ot found
make[2]: *** [arch/powerpc/boot/zImage.ps3] Error 1
make[2]: *** Waiting for unfinished jobs....
  Building modules, stage 2.
make[1]: *** [zImage] Error 2
make[1]: *** Waiting for unfinished jobs....
  MODPOST 1794 modules
ERROR: "pmu_batteries" [drivers/power/pmu_battery.ko] undefined!
ERROR: "pmu_battery_count" [drivers/power/pmu_battery.ko] undefined!
ERROR: "pmu_power_flags" [drivers/power/pmu_battery.ko] undefined!
make[2]: *** [__modpost] Error 1
make[1]: *** [modules] Error 2
make: *** [_all] Error 2

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__22_Jul_2007_00_12_12_+1000__9sDOHC4XfljpW+y
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGohRBTgG2atn1QN8RAuA/AKCMgBmdGb65wlCZNxoqbEIlql9dAQCfcf87
Gy+A4dzJXcbqF5SUTzaE8zk=
=l1Qr
-----END PGP SIGNATURE-----

--Signature=_Sun__22_Jul_2007_00_12_12_+1000__9sDOHC4XfljpW+y--
