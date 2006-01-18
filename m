Return-Path: <bgill@freescale.com>
Date: Wed, 18 Jan 2006 09:20:58 -0600 (CST)
From: Becky Bruce <bgill@freescale.com>
To: david@gibson.dropbear.id.au
Subject: [PATCH] dtc: add bus-frequency prop to SOC node
Message-ID: <Pine.LNX.4.61.0601180917080.11236@cde-tx32-ldt329.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
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

---
commit d7c0e0c8f51ac5023d92cdcf539f0ecea8a94e43
tree c66c0f8066d695e220a265cfdfbe6e508c5f3925
parent f192a7ae0ba797478920b7980159e0b2047b45f1
author Becky Bruce <becky.bruce@freescale.com> Wed, 18 Jan 2006 09:16:14 -0600
committer Becky Bruce <becky.bruce@freescale.com> Wed, 18 Jan 2006 09:16:14 -0600

 Documentation/booting-without-of.txt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/booting-without-of.txt b/Documentation/booting-without-of.txt
index 60d5b7a..39aa3c1 100644
--- a/Documentation/booting-without-of.txt
+++ b/Documentation/booting-without-of.txt
@@ -880,6 +880,9 @@ address which can extend beyond that lim
     - device_type : Should be "soc"
     - ranges : Should be defined as specified in 1) to describe the
       translation of SOC addresses for memory mapped SOC registers.  
+    - bus-frequency: Contains the bus frequency for the SOC node.
+      Typically, the value of this field is filled in by the boot
+      loader. 
 
   Recommended properties:
 
@@ -919,6 +922,7 @@ SOC.   
 		device_type = "soc";
 		ranges = <00000000 e0000000 00100000>
 		reg = <e0000000 00003000>;
+		bus-frequency = <0>;
 	}
 
 
@@ -1170,6 +1174,8 @@ platforms are moved over to use the flat
 
 	mdio@24520 {
 		reg = <24520 20>;
+		device_type = "mdio"; 
+		compatible = "gianfar";
 
 		ethernet-phy@0 {
 			......
@@ -1317,6 +1323,7 @@ not necessary as they are usually the sa
 		device_type = "soc";
 		ranges = <00000000 e0000000 00100000>
 		reg = <e0000000 00003000>;
+		bus-frequency = <0>;
 
 		mdio@24520 {
 			reg = <24520 20>;
