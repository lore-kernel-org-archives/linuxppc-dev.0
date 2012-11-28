Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id DE1082C008E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2012 14:03:17 +1100 (EST)
Date: Wed, 28 Nov 2012 14:03:08 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: linux-next: build failure after merge of the powerpc tree
Message-Id: <20121128140308.abb21ec8f61553a2ed077fe3@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Wed__28_Nov_2012_14_03_08_+1100_1GgkkmxpSg5YS496"
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linux-next@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Wed__28_Nov_2012_14_03_08_+1100_1GgkkmxpSg5YS496
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the powerpc tree, next-20121115's build (powerpc
allmodconfig) failed like this:

ERROR: ".of_reconfig_notifier_register" [drivers/crypto/nx/nx-compress.ko] =
undefined!
ERROR: ".of_reconfig_notifier_unregister" [drivers/crypto/nx/nx-compress.ko=
] undefined!

Caused by commit 1cf3d8b3d24c ("powerpc+of: Add of node/property
notification chain for adds and removes").

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Wed__28_Nov_2012_14_03_08_+1100_1GgkkmxpSg5YS496
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJQtX7sAAoJEECxmPOUX5FEAY8P/R5anO5oaEyz/wut2Cv7W13Y
IeKiNHSQiTMOg67qDL2OVxHh2PVCIhAFJ+T/Jo3RYuL99EYzW+qzYbZWjaIlzLE9
Zm51BM5SiY4aiDsUiZSqUcNnKkD+2IQy4idnri635FVGnHfy0GjhMifYhPzmgiuP
ncyUowEfsHs7IV38ObwUgBloEBImgzRg/kI0uffDBJ2cdHSEeIn4n1YVsaI1R1zK
cO2Huz/Uo3hBCWjQamsCaWXt6C9J7nqP8Qgicu21xyMvebKh5vRwroffPY6Q2XOL
Nz1U4bVak4/ARyZT2c3k6NkzqvtEDg8ccQF8l2zYDWk9strrH2Vpjvp94XOnzwY9
SrbSQORTsi6h8lN+ARNP9lIZTvtvcT7MQpUjHJNnrxU4J1nrbZFHVEY9Zc6LY6Vo
W7ZT4cBgnNt6SMhigk8ttjTopyFZd2bJoKQXrDYYHEbiD3Rmcj3zTQ0FpTRlJkp5
yJw9sIr/Fc2BSWdoVGvz35Z6+4JwpjmPc8KPpz/HggiTAbDcIV4VOB4bVKNpkKu0
POz/pc+8Wjb5uMVF4fBj6uq6s7//Mpp9GB+la8nKic3YW6Dyrca6KcPHHUu05Z72
qvpK+LuGZNe+J6P99ckAhCsaIU8g9HPAkHdnpByCP39zUuMqL2jsHGTl91NMcsI/
F78xkJoHXIPnixM9AkpN
=zloH
-----END PGP SIGNATURE-----

--Signature=_Wed__28_Nov_2012_14_03_08_+1100_1GgkkmxpSg5YS496--
