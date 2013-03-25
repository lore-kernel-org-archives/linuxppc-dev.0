Return-Path: <B32736@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EEAC52C008D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2013 12:57:08 +1100 (EST)
From: Zhicheng Fan <B32736@freescale.com>
To: <galak@kernel.crashing.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2] powerpc/dts: Fix the dts for p1025rdb 36bit
Date: Mon, 25 Mar 2013 09:23:06 +0800
Message-ID: <1364174586-26158-1-git-send-email-B32736@freescale.com>
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
 arch/powerpc/boot/dts/p1025rdb_36b.dts |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/p1025rdb_36b.dts b/arch/powerpc/boot/dts/p1025rdb_36b.dts
index 4ce4bfa..06deb6f 100644
--- a/arch/powerpc/boot/dts/p1025rdb_36b.dts
+++ b/arch/powerpc/boot/dts/p1025rdb_36b.dts
@@ -82,6 +82,11 @@
 				  0x0 0x100000>;
 		};
 	};
+
+	qe: qe@fffe80000 {
+		status = "disabled"; /* no firmware loaded */
+	};
+
 };
 
 /include/ "p1025rdb.dtsi"
-- 
1.7.0.4
