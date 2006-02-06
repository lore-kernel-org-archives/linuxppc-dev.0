Return-Path: <bgill@freescale.com>
Date: Mon, 6 Feb 2006 14:26:31 -0600 (CST)
From: Becky Bruce <bgill@freescale.com>
To: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: [PATCH] documentation: add bus-frequency property to SOC node
Message-ID: <Pine.LNX.4.61.0602061423450.18645@cde-tx32-ldt329.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Updated SOC node definition in documentation to include bus-frequency
property. Also extended mdio example to match specification.

Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
Signed-off-by: Kumar Gala <galak@gate.crashing.org>

---
commit 3441bf59c7e1dc3823f9be57838a2536c78f6f8f
tree 2901a0e19418f1fe904ff0d041c630b3af048961
parent 66c490c9b00c52cd0f1e088ad689c9148e46f49e
author Becky Bruce <becky.bruce@freescale.com> Thu, 02 Feb 2006 15:41:11 -0600
committer Becky Bruce <becky.bruce@freescale.com> Thu, 02 Feb 2006 15:41:11 -0600

 Documentation/powerpc/booting-without-of.txt |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 1284498..54e5f9b 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -880,6 +880,10 @@ address which can extend beyond that lim
     - device_type : Should be "soc"
     - ranges : Should be defined as specified in 1) to describe the
       translation of SOC addresses for memory mapped SOC registers.
+    - bus-frequency: Contains the bus frequency for the SOC node.
+      Typically, the value of this field is filled in by the boot
+      loader. 
+
 
   Recommended properties:
 
@@ -919,6 +923,7 @@ SOC.
 		device_type = "soc";
 		ranges = <00000000 e0000000 00100000>
 		reg = <e0000000 00003000>;
+		bus-frequency = <0>;
 	}
 
 
@@ -1170,6 +1175,8 @@ platforms are moved over to use the flat
 
 	mdio@24520 {
 		reg = <24520 20>;
+		device_type = "mdio"; 
+		compatible = "gianfar";
 
 		ethernet-phy@0 {
 			......
@@ -1317,6 +1324,7 @@ not necessary as they are usually the sa
 		device_type = "soc";
 		ranges = <00000000 e0000000 00100000>
 		reg = <e0000000 00003000>;
+		bus-frequency = <0>;
 
 		mdio@24520 {
 			reg = <24520 20>;
