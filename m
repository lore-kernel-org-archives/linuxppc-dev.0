Return-Path: <B32736@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B31322C00C4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2013 18:17:15 +1100 (EST)
From: Zhicheng Fan <B32736@freescale.com>
To: <galak@kernel.crashing.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/dts: Fix the dts for p1025rdb 36bit
Date: Fri, 22 Mar 2013 14:43:32 +0800
Message-ID: <1363934612-29057-1-git-send-email-B32736@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Zhicheng Fan <B32736@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

fix the following errors:
	Error: arch/powerpc/boot/dts/p1025rdb.dtsi:326.2-3 label or path, 'qe', not found
	Error: arch/powerpc/boot/dts/fsl/p1021si-post.dtsi:242.2-3 label or path, 'qe', not found
	FATAL ERROR: Syntax error parsing input tree

Signed-off-by: Zhicheng Fan <B32736@freescale.com>
---
 arch/powerpc/boot/dts/p1025rdb_36b.dts |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/p1025rdb_36b.dts b/arch/powerpc/boot/dts/p1025rdb_36b.dts
index 4ce4bfa..18f52be 100644
--- a/arch/powerpc/boot/dts/p1025rdb_36b.dts
+++ b/arch/powerpc/boot/dts/p1025rdb_36b.dts
@@ -82,6 +82,15 @@
 				  0x0 0x100000>;
 		};
 	};
+
+	qe: qe@fffe80000 {
+		ranges = <0x0 0xf 0xffe80000 0x40000>;
+		reg = <0xf 0xffe80000 0 0x480>;
+		brg-frequency = <0>;
+		bus-frequency = <0>;
+		status = "disabled"; /* no firmware loaded */
+	};
+
 };
 
 /include/ "p1025rdb.dtsi"
-- 
1.7.0.4
