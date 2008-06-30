Return-Path: <Chunbo.Luo@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 542A4DDED1
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jun 2008 14:39:30 +1000 (EST)
Subject: [POWERPC] mpc7448hpc2.dts: remove chosen node from dts
From: Chunbo Luo <chunbo.luo@windriver.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=UTF-8
Date: Mon, 30 Jun 2008 12:37:25 +0800
Message-Id: <1214800645.18447.9.camel@pek-cluo>
Mime-Version: 1.0
Reply-To: chunbo.luo@windriver.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=EF=BB=BF=EF=BB=BFModern versions of u-boot create a chosen node automatica=
lly.  So if
we set the chosen node in the dts file, there will be 2 chosen nodes
passed in to the kernel, and the kernel command line will be taken from
the wrong node.  So, remove the extra chosen node from the dts file.

=EF=BB=BFSigned-off-by: Chunbo Luo <chunbo.luo@windriver.com>

---
 arch/powerpc/boot/dts/mpc7448hpc2.dts |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc7448hpc2.dts
b/arch/powerpc/boot/dts/mpc7448hpc2.dts
index 4936349..d74727f 100644
--- a/arch/powerpc/boot/dts/mpc7448hpc2.dts
+++ b/arch/powerpc/boot/dts/mpc7448hpc2.dts
@@ -186,8 +186,5 @@
                        };
                };
        };
-       chosen {
-               linux,stdout-path =3D "/tsi108@c0000000/serial@7808";
-       };
=20
 };
---
