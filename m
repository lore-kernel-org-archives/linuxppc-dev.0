Return-Path: <sfr@canb.auug.org.au>
Received: from calzone.tip.net.au (calzone.tip.net.au
 [IPv6:2402:b800:7003:1::15])
 by ozlabs.org (Postfix) with ESMTP id BD7A01007D6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Dec 2011 12:38:19 +1100 (EST)
Date: Fri, 9 Dec 2011 12:38:11 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Josh Boyer <jwboyer@gmail.com>
Subject: linux-next: manual merge of the 4xx tree with the powerpc tree
Message-Id: <20111209123811.12cf28971f21a309976f31bb@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Fri__9_Dec_2011_12_38_11_+1100_6=FlIqzNwhf_zXaK"
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Tanmay Inamdar <tinamdar@apm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Fri__9_Dec_2011_12_38_11_+1100_6=FlIqzNwhf_zXaK
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Josh,

Today's linux-next merge of the 4xx tree got a conflict in
arch/powerpc/platforms/40x/ppc40x_simple.c between commit 11eab297f57b
("powerpc: Add support for OpenBlockS 600") from the powerpc tree and
commit d5b9ee7b514e ("powerpc/40x: Add APM8018X SOC support") from the
4xx tree.

I fixed it up (see below) and can carry the fix as necessary.

[Josh: I have changed you contact address to the above]
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --cc arch/powerpc/platforms/40x/ppc40x_simple.c
index ecac237,2f8fde6..0000000
--- a/arch/powerpc/platforms/40x/ppc40x_simple.c
+++ b/arch/powerpc/platforms/40x/ppc40x_simple.c
@@@ -55,8 -55,8 +55,9 @@@ static const char *board[] __initdata=20
  	"amcc,haleakala",
  	"amcc,kilauea",
  	"amcc,makalu",
+ 	"apm,klondike",
 -	"est,hotfoot"
 +	"est,hotfoot",
 +	"plathome,obs600"
  };
 =20
  static int __init ppc40x_probe(void)

--Signature=_Fri__9_Dec_2011_12_38_11_+1100_6=FlIqzNwhf_zXaK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJO4WaDAAoJEECxmPOUX5FEVDQQAI093vlGj3Qn/duFIvD0DDoB
rLnLIAmCIn5+cJbVsGZOtuUv0ITp7fb9pC8yXd5e58GFX8T+NW4s6twqCzVZYheP
fGSkOHFJIR3o7gVkW2W9kjMOyx/8nKqoQkrsDv9vEzcOsHGCaTzna9gEGCOlxMhb
MTRMp8j86rlE6YXDN2dPHdZSHpqaGePiw7HYR3ztNyLTpAjaDFPERoKtkOveJQM/
9GwA5MQMa+N6NiyCxP/X4/4ZTJvlA0b4jr8H8w/OlgZkrLUvFhZ/rsY5mbgxo9ij
IjGK5Xa5lOvAS+VRpAv7f3u6s/zk7JTnwdJsIVha8SaHT4QStu7EI/CfbXKXg+xi
40FktqNcXajZwY7zGWqqMVMK7mqHOnLS/D/VgPdr/vA0ftXFT/DAen/KKtQjJjQh
b1QJETa1DRWW4fm3JqO+kxJXERejehBmt7DtXxRx3OSKpTA/UVtoxmBa68UeEvL9
SmorM1kVcqxi7fEitu8VUetesRqKizdQK74J1o6hEWByj9E8XeHz6Dje2xYcpbsf
JTh9zWrmJ+rPRCpWk69D7dSjpmgq1a7WBFxMiuZevEanYqQ2J3CX0JhC/CrIwoZi
ps3MYo3XZKSBaxAeqQ0G91nKloKiOfm+XyfzLxwKntq6aRBycPzctcCzbGD8iPrc
tiEaK8+wqB+Ufs0K71Xf
=OQUJ
-----END PGP SIGNATURE-----

--Signature=_Fri__9_Dec_2011_12_38_11_+1100_6=FlIqzNwhf_zXaK--
