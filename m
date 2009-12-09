Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id E3DBFB6F04
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Dec 2009 16:11:20 +1100 (EST)
Date: Wed, 9 Dec 2009 00:04:37 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Josh Boyer
	<jwboyer@linux.vnet.ibm.com>
Subject: [PATCH] powerpc: Increase warp SD buffer
Message-ID: <20091209000437.78794a8f@opus.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Newer revs of the FPGA have a larger SD buffer.

Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
---
diff --git a/arch/powerpc/boot/dts/warp.dts b/arch/powerpc/boot/dts/warp.dts
index 31605ee..e576ee8 100644
--- a/arch/powerpc/boot/dts/warp.dts
+++ b/arch/powerpc/boot/dts/warp.dts
@@ -146,7 +146,7 @@
 
 				fpga@2,4000 {
 					compatible = "pika,fpga-sd";
-					reg = <0x00000002 0x00004000 0x00000A00>;
+					reg = <0x00000002 0x00004000 0x00004000>;
 				};
 
 				nor@0,0 {
