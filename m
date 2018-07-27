Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41cLvl0hDdzDqkJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2018 17:59:15 +1000 (AEST)
Date: Fri, 27 Jul 2018 17:59:11 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, PowerPC
 <linuxppc-dev@lists.ozlabs.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Stefan Popa
 <stefan.popa@analog.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Michael Hanselmann <linux-kernel@hansmi.ch>
Subject: linux-next: manual merge of the staging tree with the powerpc tree
Message-ID: <20180727175911.76ed6d44@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/L97V92Xz7lZANjfkOVsej2B"; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/L97V92Xz7lZANjfkOVsej2B
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the staging tree got a conflict in:

  MAINTAINERS

between commit:

  d69ccc00c497 ("MAINTAINERS: Remove the entry for the orphaned ams driver")

from the powerpc tree and commit:

  28d1a7ac2a0d ("iio: dac: Add AD5758 support")

from the staging tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc MAINTAINERS
index fc92aab3ca2a,b9503cefc42d..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -807,6 -791,19 +807,14 @@@ S:	Supporte
  F:	drivers/net/ethernet/amd/xgbe/
  F:	arch/arm64/boot/dts/amd/amd-seattle-xgbe*.dtsi
 =20
 -AMS (Apple Motion Sensor) DRIVER
 -M:	Michael Hanselmann <linux-kernel@hansmi.ch>
 -S:	Supported
 -F:	drivers/macintosh/ams/
 -
+ ANALOG DEVICES INC AD5758 DRIVER
+ M:	Stefan Popa <stefan.popa@analog.com>
+ L:	linux-iio@vger.kernel.org
+ W:	http://ez.analog.com/community/linux-device-drivers
+ S:	Supported
+ F:	drivers/iio/dac/ad5758.c
+ F:	Documentation/devicetree/bindings/iio/dac/ad5758.txt
+=20
  ANALOG DEVICES INC AD5686 DRIVER
  M:	Stefan Popa <stefan.popa@analog.com>
  L:	linux-pm@vger.kernel.org

--Sig_/L97V92Xz7lZANjfkOVsej2B
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlta0M8ACgkQAVBC80lX
0GzA1wf/SAWQBwpGl2//kv3uNZcfXQbHK1Igv2Ep82CgDzsyA6W2J34947rS9m9r
MokmbvEcac4BJWVRVismDosGNNFwYZiTxI1XHsmj5pZIUxzF9ejCAiN/R8wcy4Z2
bkHn3MAThP9HWVFYmT9VGXEpTHkhPuWNvgmmVfr+xre/PaSBrIs8gMAnotF/+0qB
cTRufaMJfEpgXatqE8sGvtx0WMsRwtP1hF8AOlHOKt0SRk1ibOOBQQ7uhROvZCCw
M755bev3wwaQ3C9YRR6lDrEy+33qa2h3Ohe1Lt6e3ozb+1wDgm1XvFEwbkkd73wS
DZ8cfYBeytGlYRmmX1ha4RWGM4U7rg==
=Rdb9
-----END PGP SIGNATURE-----

--Sig_/L97V92Xz7lZANjfkOVsej2B--
