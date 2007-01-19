Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.191.145]) by ozlabs.org (Postfix) with ESMTP id 1F057DDE2C
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jan 2007 18:00:47 +1100 (EST)
From: grant.likely@secretlab.ca
To: linuxppc-dev@ozlabs.org, paulus@samba.org, tnt@346tnt.com,
	segher@kernel.crashing.org
Subject: [POWERPC] Make it blatantly clear;
	mpc5200 device tree is not yet stable
Date: Fri, 19 Jan 2007 00:00:14 -0700
Message-Id: <1169190014769-git-send-email-grant.likely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Documentation-only change.  The 5200 device tree layout has not yet
stablized, so nobody should depend on the layout of the tree.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
Paul,

(minor rework from comments received)

I know it's *very* late in the .20 release cycle, but I don't want to
allow false assumptions about the stability of the 5200 device tree
bindings.

Please apply for 2.6.20 If you think it is appropriate.

Thanks,
g.

 .../powerpc/mpc52xx-device-tree-bindings.txt       |    6 ++++++
 arch/powerpc/boot/dts/lite5200.dts                 |    6 ++++++
 arch/powerpc/boot/dts/lite5200b.dts                |    6 ++++++
 3 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/Documentation/powerpc/mpc52xx-device-tree-bindings.txt b/Documentation/powerpc/mpc52xx-device-tree-bindings.txt
index 7fb3b8a..69f016f 100644
--- a/Documentation/powerpc/mpc52xx-device-tree-bindings.txt
+++ b/Documentation/powerpc/mpc52xx-device-tree-bindings.txt
@@ -4,6 +4,12 @@ MPC52xx Device Tree Bindings
 (c) 2006 Secret Lab Technologies Ltd
 Grant Likely <grant.likely at secretlab.ca>
 
+********** DRAFT ***********
+* WARNING: Do not depend on the stability of these bindings just yet.
+* The MPC5200 device tree conventions are still in flux
+* Keep an eye on the linuxppc-dev mailing list for more details
+********** DRAFT ***********
+
 I - Introduction
 ================
 Boards supported by the arch/powerpc architecture require device tree be
diff --git a/arch/powerpc/boot/dts/lite5200.dts b/arch/powerpc/boot/dts/lite5200.dts
index a8efb59..1868707 100644
--- a/arch/powerpc/boot/dts/lite5200.dts
+++ b/arch/powerpc/boot/dts/lite5200.dts
@@ -10,6 +10,12 @@
  * option) any later version.
  */
 
+/*
+ * WARNING: Do not depend on this tree layout remaining static just yet.
+ * The MPC5200 device tree conventions are still in flux
+ * Keep an eye on the linuxppc-dev mailing list for more details
+ */
+
 / {
 	model = "Lite5200";
 	compatible = "lite5200\0lite52xx\0mpc5200\0mpc52xx";
diff --git a/arch/powerpc/boot/dts/lite5200b.dts b/arch/powerpc/boot/dts/lite5200b.dts
index 1aabee4..5bb2760 100644
--- a/arch/powerpc/boot/dts/lite5200b.dts
+++ b/arch/powerpc/boot/dts/lite5200b.dts
@@ -10,6 +10,12 @@
  * option) any later version.
  */
 
+/*
+ * WARNING: Do not depend on this tree layout remaining static just yet.
+ * The MPC5200 device tree conventions are still in flux
+ * Keep an eye on the linuxppc-dev mailing list for more details
+ */
+
 / {
 	model = "Lite5200b";
 	compatible = "lite5200b\0lite52xx\0mpc5200b\0mpc52xx";
-- 
1.4.3.rc2.g0503
