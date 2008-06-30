Return-Path: <Chunbo.Luo@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 77E83DDE9E
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jun 2008 17:20:26 +1000 (EST)
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id m5U35lqs010638
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Jun 2008 20:05:47 -0700 (PDT)
Subject: [POWERPC] mpc7448hpc2.dts: remove chosen node from dts
From: Chunbo Luo <chunbo.luo@windriver.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=UTF-8
Date: Mon, 30 Jun 2008 11:03:52 +0800
Message-Id: <1214795032.9125.7.camel@pek-cluo>
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

=EF=BB=BFModern versions of u-boot create a chosen node automatically.  So =
if
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
-	chosen {
-		linux,stdout-path =3D "/tsi108@c0000000/serial@7808";
-	};
=20
 };
---
