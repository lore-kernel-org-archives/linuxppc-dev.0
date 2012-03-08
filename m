Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id E174BB6FE3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2012 15:43:42 +1100 (EST)
Date: Thu, 8 Mar 2012 15:39:31 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 5/7] tty: powerpc: remove SERIAL_ICOM dependency on PPC_ISERIES
Message-Id: <20120308153931.b1b8b4f27d8e4a94b219bf4c@canb.auug.org.au>
In-Reply-To: <20120308152853.b5010336abbb8f90e8a2500c@canb.auug.org.au>
References: <20120308152853.b5010336abbb8f90e8a2500c@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Thu__8_Mar_2012_15_39_31_+1100_R04eX+iOgbS1NNt5"
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Thu__8_Mar_2012_15_39_31_+1100_R04eX+iOgbS1NNt5
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The PowerPC legacy iSeries platform is being removed so this is no
longer selectable.

Cc: Alan Cox <alan@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/tty/serial/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 2de9924..59e7983 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -853,7 +853,7 @@ config SERIAL_MPC52xx_CONSOLE_BAUD
=20
 config SERIAL_ICOM
 	tristate "IBM Multiport Serial Adapter"
-	depends on PCI && (PPC_ISERIES || PPC_PSERIES)
+	depends on PCI && PPC_PSERIES
 	select SERIAL_CORE
 	select FW_LOADER
 	help
--=20
1.7.9.1

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Thu__8_Mar_2012_15_39_31_+1100_R04eX+iOgbS1NNt5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPWDgDAAoJEECxmPOUX5FE7nEP/1VKdbI5IpjGcv13R6mszDdS
6wvNIM1nZKE05EECB7tNys4xSB9D9vwiYFTH+H5cY7gLPdmqbDqxMZ0q/yVI2zxE
jvbeS3ASyVVzBNiDlUByS9xy7Rpdy7gY+VYz0fvCmxad07FuRGHgqr18o2pNt7f+
Qa9MAy+Xifn59nEGjGQhkmSXv4hpXE1NrJQmJ0rt7vhHTmtO531Q45uoJ142Yci4
9Yy/Bc3Mh4LSihhZoikkFEgQDObZDOTpohHJ0nkfiCVTGYTXSvFf8yv8Ih77vNq6
UGQ9RLZTUgJPm9tZHblBzWNJu5YTFVgLafa9+id7ycBVdqtrGeVaP+vAVaEVxqRs
MoIapV9PE0isdgDuF4HtNMH8XFJXTSobsGhbOcVNdCTYkQ0PEUnFB8/Vd7FKT2Bf
tOTkFNZEp/MjPh8omN13aLPwG1KCvv66N02JBJ0FGJ/nyNEN+7hKVFKBrEAxcDMD
UoMHsZEisfnfEEkc8rckc+yH4+LKmRr1tHA6ClL3kyd/x1G1wA9zAZTWuBwSoEPx
GXlK1H+FU1L8qAOF+WnlXtQA2ZedFZxclXoodxilTLnGdXZvCuYzHP0eN2yjsWut
N5FsgMCu+X4F8eIUCHKOzfetdRr6DapQHCa5WFqAuIvPKGSdqJSDZTleFYbSphZC
iZk0BGt2/KefUK/kOo0b
=HssQ
-----END PGP SIGNATURE-----

--Signature=_Thu__8_Mar_2012_15_39_31_+1100_R04eX+iOgbS1NNt5--
