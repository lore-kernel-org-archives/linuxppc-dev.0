Return-Path: <Nora.Bjorklund@enea.com>
Received: from mx-3.enea.com (sestofw01.enea.se [192.36.1.252])
 by lists.ozlabs.org (Postfix) with SMTP id 3qTCJ54bYHzDq7K
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Mar 2016 21:49:24 +1100 (AEDT)
From: =?UTF-8?q?Nora=20Bj=C3=B6rklund?= <nora.bjorklund@enea.com>
To: <linuxppc-dev@lists.ozlabs.org>, <benh@kernel.crashing.org>
CC: <oss@buserror.net>, =?UTF-8?q?Nora=20Bj=C3=B6rklund?=
 <nora.bjorklund@enea.com>
Subject: [PATCH] powerpc:dts:p2041rdb: enable gpio-expander
Date: Mon, 21 Mar 2016 11:48:51 +0100
Message-ID: <1458557331-59540-1-git-send-email-nora.bjorklund@enea.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Enable the gpio-expander pca9672 on p2041rdb. The expander
has been present on the p2041rdb all along, however not in
the device tree.

Signed-off-by: Nora Bj=C3=B6rklund <nora.bjorklund@enea.com>
---
 arch/powerpc/boot/dts/fsl/p2041rdb.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/p2041rdb.dts b/arch/powerpc/boot/dts=
/fsl/p2041rdb.dts
index e9bd894..b1ee561 100644
--- a/arch/powerpc/boot/dts/fsl/p2041rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/p2041rdb.dts
@@ -134,6 +134,13 @@
 			};
 		};
=20
+		i2c@119100 {
+			gpio@22 {
+				compatible =3D "pcf8575";
+				reg =3D <0x22>;
+			};
+		};
+
 		usb1: usb@211000 {
 			dr_mode =3D "host";
 		};
--=20
1.9.1
