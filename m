Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.191.145]) by ozlabs.org (Postfix) with ESMTP id 022E1DDE4A
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Jan 2007 10:58:48 +1100 (EST)
From: grant.likely@secretlab.ca
To: linuxppc-dev@ozlabs.org,
	paulus@samba.org,
	tnt@246tnt.com
Subject: [PATCH] [POWERPC] Make it blatently clear;
	5200 device tree is not yet stable
Date: Sat, 13 Jan 2007 16:58:19 -0700
Message-Id: <11687326992407-git-send-email-grant.likely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

---
Paulus,

Please apply for 2.6.20.  This is documentation only, but I don't want
to give people false assumptions about the stability of the 5200 device
tree bindings

 .../powerpc/mpc52xx-device-tree-bindings.txt       |    9 +++++++++
 arch/powerpc/boot/dts/lite5200.dts                 |    8 ++++++++
 arch/powerpc/boot/dts/lite5200b.dts                |    8 ++++++++
 3 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/Documentation/powerpc/mpc52xx-device-tree-bindings.txt b/Documentation/powerpc/mpc52xx-device-tree-bindings.txt
index 7fb3b8a..e90efe3 100644
--- a/Documentation/powerpc/mpc52xx-device-tree-bindings.txt
+++ b/Documentation/powerpc/mpc52xx-device-tree-bindings.txt
@@ -4,6 +4,15 @@ MPC52xx Device Tree Bindings
 (c) 2006 Secret Lab Technologies Ltd
 Grant Likely <grant.likely at secretlab.ca>
 
+********** DRAFT ***********
+* WARNING: Do not depend on definiton remaining static between
+* kernel versions.  The 5200 device tree conventions are still in flux
+* and could change without notice.  Keep an eye on the linuxppc-dev
+* mailing list for more details
+*
+* Hopefully by 2.6.21 it will be stable.  ---gcl, Jan 13, 2007
+********** DRAFT ***********
+
 I - Introduction
 ================
 Boards supported by the arch/powerpc architecture require device tree be
diff --git a/arch/powerpc/boot/dts/lite5200.dts b/arch/powerpc/boot/dts/lite5200.dts
index a8efb59..e953568 100644
--- a/arch/powerpc/boot/dts/lite5200.dts
+++ b/arch/powerpc/boot/dts/lite5200.dts
@@ -10,6 +10,14 @@
  * option) any later version.
  */
 
+/*
+ * WARNING: Do not depend on this tree remaining static between
+ * kernel versions.  The 5200 device tree conventions are still in flux
+ * and could change without notice.
+ *
+ * Hopefully by 2.6.21 it will be stable.  ---gcl, Jan 13, 2007
+ */
+
 / {
 	model = "Lite5200";
 	compatible = "lite5200\0lite52xx\0mpc5200\0mpc52xx";
diff --git a/arch/powerpc/boot/dts/lite5200b.dts b/arch/powerpc/boot/dts/lite5200b.dts
index 1aabee4..c3123be 100644
--- a/arch/powerpc/boot/dts/lite5200b.dts
+++ b/arch/powerpc/boot/dts/lite5200b.dts
@@ -10,6 +10,14 @@
  * option) any later version.
  */
 
+/*
+ * WARNING: Do not depend on this tree remaining static between
+ * kernel versions.  The 5200 device tree conventions are still in flux
+ * and could change without notice.
+ *
+ * Hopefully by 2.6.21 it will be stable.  ---gcl, Jan 13, 2007
+ */
+
 / {
 	model = "Lite5200b";
 	compatible = "lite5200b\0lite52xx\0mpc5200b\0mpc52xx";
-- 
1.4.3.rc2.g0503
